# Catalyst CV — Functional MVP

This version turns the landing page into an actual CV application: authentication, user dashboard, CV CRUD, live editor, four templates, PDF generation, AI summary endpoint, and M-Pesa STK backend.

## 1. Supabase
Create a project at https://supabase.com/ and run `supabase.sql` in the SQL Editor.

In Supabase Authentication, decide whether email confirmation is required. For a smoother first test, disable email confirmation temporarily; enable it for production.

## 2. Configure the frontend
Open `index.html` and replace:
- `YOUR_SUPABASE_URL`
- `YOUR_SUPABASE_ANON_KEY`

The anon key is intended for browser use with RLS enabled. Never put the Supabase service-role key in `index.html`.

## 3. Vercel environment variables
Set these in Vercel:
- `SUPABASE_URL`
- `SUPABASE_ANON_KEY`
- `SUPABASE_SERVICE_ROLE_KEY`
- `OPENAI_API_KEY` (optional until AI is needed)
- `OPENAI_MODEL` (optional; defaults to `gpt-5.6-luna`)
- `MPESA_ENV=sandbox` for testing, then `production`
- `MPESA_CONSUMER_KEY`
- `MPESA_CONSUMER_SECRET`
- `MPESA_SHORTCODE`
- `MPESA_PASSKEY`
- `MPESA_CALLBACK_URL=https://YOUR-DOMAIN/api/mpesa-callback`

## 4. M-Pesa
Create/configure a Daraja app and use the sandbox first. The callback URL must be publicly reachable over HTTPS. The callback endpoint records the payment and marks the user's CVs premium after a successful STK result.

## 5. Deploy
Import this folder into GitHub and deploy the repository with Vercel. No build command is required.

## What is genuinely live
- Register / login
- Session persistence through Supabase Auth
- Dashboard
- Create / edit / delete CVs
- Multiple experience and education records
- Skills and certifications
- Template selection
- Live preview
- Save to database
- PDF download
- AI endpoint when OpenAI is configured
- M-Pesa STK when Daraja credentials and callback are configured

## Still worth adding before public launch
- Forgot-password UI
- Email verification UX
- Profile settings
- CV duplication
- More templates
- ATS scoring engine
- Job description tailoring
- Usage/rate limits
- Stronger payment entitlement logic (premium should be account-level, not only CV-level)
- Privacy policy, terms, support and deletion workflow
