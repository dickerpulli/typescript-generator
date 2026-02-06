# How to release typescript-generator

- change version in `pom.xml` files and `.github/workflows/build.yml` (if not already changed)
- wait for the build of GitHub Action "Build"
- run "Release to Maven Central" GitHub Action which releases the artifacts from build of GitHub Action "Build"
- go to https://central.sonatype.com and promote the release
    - "Staging Repositories"
    - "Close" the repo
    - wait for closing activities
    - "Release" the repo
- wait for the release to appear in Maven Central - https://repo1.maven.org/maven2/de/codecentric/typescript-generator/
- write release notes
- run "Release to Gradle plugin portal" GitHub Action
- close/update relevant issues and PRs
- remove unused tags
