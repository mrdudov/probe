import { Injectable } from "@angular/core";
import { HttpClient, HttpErrorResponse } from '@angular/common/http'
import { User } from "src/app/shared/interfaces";
import { catchError, Observable, Subject, tap, throwError } from "rxjs";
import { environment } from "src/environments/environment";

const login_url = `https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=${environment.apiKey}`

@Injectable({
    providedIn: 'root'
})
export class AuthServices {

    public error$: Subject<string> = new Subject<string>()

    constructor(
        private http: HttpClient
    ) {}

    get token(): string | null {
        const expDate = new Date(localStorage.getItem('fb-token-exp')!)
        if (new Date() > expDate ) {
            this.logout()
            return null
        }
        return localStorage.getItem('fb-token')!
    }

    login(user: User): Observable<any> {
        user.returnSecureToken = true
        return this.http.post(login_url, user)
            .pipe(
                tap(this.setToken),
                catchError(this.handleError.bind(this))
            )
    }

    logout() {
        this.setToken(null)
    }

    isAuthenticated(): boolean {
        return Boolean(this.token)
    }

    private handleError(error: HttpErrorResponse) {
        const { message } = error.error.error
        switch (message) {
            case 'EMAIL_NOT_FOUND':
                this.error$.next('EMAIL_NOT_FOUND')
                break;
            case 'INVALID_EMAIL':
                this.error$.next('INVALID_EMAIL')
                break;
            case 'INVALID_PASSWORD':
                this.error$.next('INVALID_PASSWORD')
                break;
        }
        return throwError(() => new Error(message))
    }

    // private setToken(response: FbAuthResponse) {
    private setToken(response: any) {
        if (response) {
            const expDate = new Date(
                new Date().getTime() 
                + parseInt(response.expiresIn) * 1000
            )
            localStorage.setItem('fb-token', response.idToken)
            localStorage.setItem('fb-token-exp', expDate.toString())
        } else {
            localStorage.clear()
        }
    }
}
