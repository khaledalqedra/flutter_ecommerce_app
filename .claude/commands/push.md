# Smart Git Commit & Push

Follow these steps exactly, in order:

## 1. Inspect the working tree

Run these in parallel:
- `git status` — see what files changed
- `git diff HEAD` — see the full diff of all changes

## 2. Stage all changes

Run `git add -A` to stage everything.

If any file looks like it should NOT be committed (e.g. `.env`, secrets, large binaries, generated files that are gitignored), unstage it with `git restore --staged <file>` and warn the user before continuing.

## 3. Determine the commit type

Choose exactly one prefix based on the staged diff:

| Prefix | When to use |
|--------|-------------|
| `feat` | New feature or user-visible capability added |
| `fix`  | Bug fix, crash fix, or incorrect behavior corrected |
| `chore`| Dependency bumps, config changes, build scripts, generated files, refactors with no behavior change |
| `docs` | Documentation-only changes |
| `style`| Formatting, whitespace — no logic change |
| `refactor` | Code restructure with no feature or fix |
| `test` | Adding or updating tests |

## 4. Write the commit message

Rules:
- First line: `<type>(<optional-scope>): <short imperative summary>` — max 72 chars, no period.
- If the changes span multiple concerns, add a blank line then bullet points covering each area.
- Be specific about WHAT changed and WHY, not HOW.
- Do NOT include phrases like "added for the X flow" or reference issue numbers unless the user provides them.

Example:
```
feat(auth): add Google sign-in with token refresh

- Wire GoogleSignIn result into AuthCubit
- Persist user data to Firestore on first login
- Show error snackbar on cancellation
```

## 5. Commit

Run the commit using a HEREDOC so multi-line messages are preserved:

```bash
git commit -m "$(cat <<'EOF'
<your message here>
EOF
)"
```

## 6. Push

Run `git push` to push the current branch to its remote tracking branch.

If there is no upstream set, run `git push --set-upstream origin <current-branch>`.

## 7. Report back

Show the user:
- The commit hash and message
- Which branch was pushed to
- Any warnings (e.g. files skipped, no changes found)

If there are no staged changes after step 2, stop and tell the user there is nothing to commit.
