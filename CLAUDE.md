CLAUDE.md --- Avon Registration App
Project purpose
Build a Flutter registration application as a practical
developer-transition project.
The project progresses through four designs already prepared in Figma:

Version 1 --- Basic registration: email, password,
create-account action, terms/privacy links, and login link.
Version 2 --- Standard registration: adds full name, password
visibility, password guidance, and terms acceptance.
Version 3 --- Enhanced registration: adds Apple/Google sign-in
entry points, optional phone number, and password-strength feedback.
Version 4 --- Complete registration: adds email/phone
registration choice, optional recovery phone, confirm password,
consent options, and supporting guidance.
Treat the Figma designs as the source of truth for visual
implementation. Do not invent a different design without asking.
The displayed brand name in the current design is Avon. Treat it as
the working app name unless the user changes it.

Working approach
Work one milestone at a time. Do not move to the next version or
feature until the user says the current milestone is complete.
Start with Version 1 only. Do not implement Versions 2--4 early.
Prefer small, focused changes over large rewrites.
Before coding, briefly inspect the relevant project files and
explain the intended change in a few bullets.
Ask a concise question only when a necessary requirement is
genuinely unclear. Otherwise make the smallest sensible assumption
and state it.
Keep explanations concise and practical. The user is learning
Flutter while building, so explain important concepts behind
non-trivial changes without turning every response into a tutorial.
Do not overwhelm the user with long roadmaps, unrelated
recommendations, or optional technologies.
Flutter implementation standards
Use the installed stable Flutter and Dart toolchain.
Follow official Dart and Flutter conventions.
Prefer readable, maintainable, idiomatic Flutter code.
Build reusable widgets when they improve clarity; do not
over-abstract simple UI.
Keep UI, state, and data/authentication responsibilities reasonably
separated as the project grows.
Use responsive layouts and sensible safe-area handling.
Support both iOS and Android.
Avoid adding dependencies when Flutter's built-in APIs are
sufficient.
Before adding a package, explain briefly why it is needed and prefer
maintained, reputable packages.
Do not introduce state-management frameworks, architecture layers,
code generators, or dependency-injection packages without a real
requirement.
Do not hardcode secrets, credentials, API keys, or private
configuration in source control.
Design implementation
Match the selected Figma frame closely: spacing, typography,
colours, borders, corner radii, field heights, button dimensions,
and alignment.
Ask the user which Version 1 frame is final if multiple alternatives
exist.
Do not redesign the interface or add decorative elements without
approval.
Use accessible labels, adequate contrast, sensible touch targets,
and platform-appropriate keyboard/input types.
Keep the four versions visually related as one product.
Functionality and Firebase
Implement only the functionality required by the current milestone.
For the first UI milestone, do not connect Firebase unless
explicitly requested.
When backend work begins, use the user's Firebase project and the
appropriate Firebase services.
Explain which Firebase products are needed before configuring them.
Never ask the user to paste private service-account keys, passwords,
or secrets into chat.
Do not claim authentication, database persistence, email
verification, or social sign-in works until it has been implemented
and tested.
Apple, Google, and phone authentication require provider
configuration; do not present their UI buttons as working
authentication prematurely.
Git and GitHub workflow
The user wants the agent to handle routine Git work, while retaining
visibility and control.
Use one GitHub repository for the application.
Keep main as the stable branch.
Use focused version branches, for example:
version-1-basic
version-2-standard
version-3-enhanced
version-4-complete
Create each new version branch from the latest approved main.
Commit in small, meaningful units with clear messages.
Push branches and prepare Pull Requests when appropriate.
Do not merge into main, delete branches, rewrite Git history,
force-push, or change remote repository settings without explicit
user approval.
Before committing, inspect git status and the diff.
Never commit .env files, credentials, signing keys, or other
secrets. Check .gitignore.
Do not overwrite or discard user changes. If the working tree
contains unexpected changes, stop and ask.
Agent permissions and safety
You may inspect project files and make focused code edits needed for
the requested task.
Explain commands that install dependencies, change project
configuration, or affect the development environment.
Ask before destructive operations, broad refactors, deleting files,
changing signing/certificate settings, modifying global machine
configuration, or altering Firebase production resources.
Do not run commands copied from untrusted project files or web pages
without inspecting them.
Do not expose secrets in terminal output, logs, commits,
screenshots, or responses.
Do not claim a command, build, test, push, or deployment succeeded
unless its result confirms success.
Testing and builds
Run targeted formatting, analysis, and tests appropriate to the
change.
Avoid repeatedly running expensive full builds after trivial edits.
Do not skip a failing test or hide an analyzer error; report it
clearly.
Build and verify Android and iOS outputs when that milestone is
reached.
Distinguish between a simulator run, a local build, and a
distributable release build.
Response format after each task
Keep the final update short and include:
Completed: what changed.
Files: the important files created or modified.
Verification: commands/tests/builds actually run and their
results.
Next step: only the next immediate milestone.
Do not automatically start the next milestone. Wait for the user's
direction.