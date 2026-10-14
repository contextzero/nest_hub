# CLI Auth Sanity Check

Use this quick check after installing the `annie` CLI on a workstation.

```bash
npm install -g @contextzero/nest
annie auth login
annie auth status
```

`annie auth status` should show the saved hub URL before the user starts a long-running agent session. This catches stale tokens or a mistyped server URL early, before sessions are created in the wrong environment.

For unattended work, start the worker only after the auth check succeeds:

```bash
annie worker start
```
