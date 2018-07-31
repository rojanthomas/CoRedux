#!/bin/bash
#
# Deploy a jar, source jar, and javadoc jar to Sonatype's snapshot repo.
#
# Adapted from https://coderwall.com/p/9b_lfq and
# http://benlimmer.com/2013/12/26/automatically-publish-javadoc-to-gh-pages-with-travis-ci/

SLUG="freeletics/RxRedux"
JDK="oraclejdk8"
BRANCH="master"

set -e

if [ "$TRAVIS_REPO_SLUG" != "$SLUG" ]; then
  echo "Skipping deployment: wrong repository. Expected '$SLUG' but was '$TRAVIS_REPO_SLUG'."
elif [ "$TRAVIS_JDK_VERSION" != "$JDK" ]; then
  echo "Skipping deployment: wrong JDK. Expected '$JDK' but was '$TRAVIS_JDK_VERSION'."
elif [ "$TRAVIS_PULL_REQUEST" != "false" ]; then
  echo "Skipping deployment: was pull request."
elif [ "$TRAVIS_BRANCH" != "$BRANCH" ]; then
  echo "Skipping  deployment: wrong branch. Expected '$BRANCH' but was '$TRAVIS_BRANCH'."
else
  echo "Deploying ..."
  openssl aes-256-cbc -K $encrypted_06b1e6b9a94a_key -iv $encrypted_06b1e6b9a94a_iv -in freeletics.gpg.enc -out freeletics.gpg -d
  echo "signing.password=$PGP_KEY" >> library/gradle.properties
  echo "signing.secretKeyRingFile=$PWD/freeletics.gpg" >> library/gradle.properties
  ./gradlew :library:uploadArchives
  rm freeletics.gpg
  git reset --hard
  echo "Snapshot deployed!"
fi
