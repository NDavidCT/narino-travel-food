Setup notes for local Google Sign-In testing (ready-to-paste)

Project: apptouripi (project number 187733989912)
OAuth Web Client ID: 187733989912-4tl32be27591kovqe935jir5kpmrduiv.apps.googleusercontent.com

1) Google Cloud Console (open the OAuth client edit page)
   https://console.cloud.google.com/apis/credentials?project=187733989912

2) Add JavaScript origins (Authorized JavaScript origins) - paste each line and Save:
   http://localhost:56401
   http://localhost:59047
   http://localhost:61684
   http://127.0.0.1:56401
   http://127.0.0.1:59047
   http://127.0.0.1:61684
   https://apptouripi.firebaseapp.com
   https://apptouripi.web.app

3) Add redirect URIs (Authorized redirect URIs) - paste and Save:
   http://localhost:56401/__/auth/handler
   http://localhost:59047/__/auth/handler
   http://localhost:61684/__/auth/handler
   https://apptouripi.firebaseapp.com/__/auth/handler
   https://apptouripi.web.app/__/auth/handler

4) Optional: verify the OAuth client ID above matches the one in your app (web/index.html or the singleton in code).

5) Local run (PowerShell):
   # run on a fixed port (example 56401)
   .\run_chrome_local.ps1 -Port 56401

6) Open the app and test "Continuar con Google". If you see errors, open DevTools → Network and copy the failing request's URL (I can tell you the exact URI to add).
