import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Params, Router } from '@angular/router';
import { User } from 'src/app/shared/interfaces';
import { AuthServices } from '../shared/services/auth.service';

@Component({
  selector: 'app-login-page',
  templateUrl: './login-page.component.html',
  styleUrls: ['./login-page.component.scss']
})
export class LoginPageComponent implements OnInit {

  form: FormGroup
  submitted = false
  message: string = ''

  constructor(
    public auth: AuthServices,
    private router: Router,
    private route: ActivatedRoute
  ) {
    this.form = new FormGroup({
      email: new FormControl(null, [
        Validators.required, 
        Validators.email
      ]),
      password: new FormControl(null, [
        Validators.required,
        Validators.minLength(6)
      ])
    })
   }

  ngOnInit(): void {
    this.route.queryParams.subscribe((params: Params) => {
      if (params['loginAgain']) {
        this.message = 'login again'
      } else if (params['authFailed']) {
        this.message = 'auth failed'
      }
    })
  }

  submit() {
    if (this.form.invalid) {
      return
    }
    this.submitted = true
    const user: User = {
      email: this.form.value.email,
      password: this.form.value.password,
    }

    this.auth.login(user).subscribe(() => {
      this.form.reset()
      this.router.navigate(['/admin', 'dashboard'])
      this.submitted = false
    }, () => {
      this.submitted = false
    })

  }
}
