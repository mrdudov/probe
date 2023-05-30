import { HttpErrorResponse, HttpEvent, HttpHandler, HttpInterceptor, HttpRequest } from "@angular/common/http";
import { Injectable } from "@angular/core";
import { Router } from "@angular/router";
import { catchError, Observable, throwError } from "rxjs";
import { AuthServices } from "../admin/shared/services/auth.service";

@Injectable()
export class AuthInterceptor implements HttpInterceptor{
    
    constructor(
        private auth: AuthServices,
        private router: Router
    ) {}
    
    intercept(req: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
        if (this.auth.isAuthenticated()) {
            req = req.clone({
                setParams: {
                    auth: this.auth.token || '' //TODO: may be this is a bug (|| '')
                }
            })
        }
        return next.handle(req)
            .pipe(
                catchError((error: HttpErrorResponse) => {
                    console.log('[Interceptor Error]: ', error)
                    if (error.status === 401 ) {
                        this.auth.logout()
                        this.router.navigate(['/admin', 'login'], {
                            queryParams: {
                                authFailed: true
                            }
                        })
                    }
                    return throwError(error)
                })
            )
    }

}