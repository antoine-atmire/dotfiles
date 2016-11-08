#!/bin/sh

function prepare_deploy () {
  if [ -z $4 ] ; then
    echo "Usage: prepare_deploy <branch> <old-minor> <new-minor> <commits to cherry-pick>"
    echo "example: prepare_deploy 5.1 4.0.23-0 4.0.24-0 ffed896 a1d6efa"
  else
    branch="$1"
    shift
    old_minor="$1"
    shift
    new_minor="$1"
    shift
    echo ""
    echo ➜ git checkout $branch
    git checkout $branch
    echo ""
    echo ➜ git pull
    git pull
    echo ""
    echo ➜ git cherry-pick -x $*
    git cherry-pick -x $*
    if [ $? -eq 0 ] ; then
      echo ""
      echo ➜ change_versions $branch-$old_minor $branch-$new_minor
      /Users/antoine/bin/change_versions $branch-$old_minor $branch-$new_minor
      echo ""
      echo ➜ git commit -a -m "Bump version number to $branch-$new_minor"
      git commit -a -m "Bump version number to $branch-$new_minor"
      echo ""
      echo ➜ git tag -a "v$branch-$new_minor" -m "v$branch-$new_minor" 
      git tag -a "v$branch-$new_minor" -m "v$branch-$new_minor" 
      echo ""
      echo ➜ git push origin $branch
      git push origin $branch
      echo ""
      echo ➜ git push origin v$branch-$new_minor
      git push origin v$branch-$new_minor
    else
      echo "git cherry-pick exited with status code $?"
    fi
  fi
}

function prepare_deploy_no_cherry () {
  if [ -z $3 ] ; then
    echo "Usage: ~/handy\ code/scripts/prepare_deploy_no_cherry-pick <branch> <old-minor> <new-minor>"
    echo "example: ~/handy\ code/scripts/prepare_deploy_no_cherry-pick 5.1 4.0.23-0 4.0.24-0"
  else
    branch="$1"
    shift
    old_minor="$1"
    shift
    new_minor="$1"
    shift
    echo ""
    echo ➜ git checkout $branch
    git checkout $branch
    echo ""
    echo ➜ git pull
    git pull
    echo ""
    echo ➜ change_versions $branch-$old_minor $branch-$new_minor
    /Users/antoine/bin/change_versions $branch-$old_minor $branch-$new_minor
    echo ""
    echo ➜ git commit -a -m "Bump version number to $branch-$new_minor"
    git commit -a -m "Bump version number to $branch-$new_minor"
    echo ""
    echo ➜ git tag -a "v$branch-$new_minor" -m "v$branch-$new_minor" 
    git tag -a "v$branch-$new_minor" -m "v$branch-$new_minor" 
    echo ""
    echo ➜ git push origin $branch
    git push origin $branch
    echo ""
    echo ➜ git push origin v$branch-$new_minor
    git push origin v$branch-$new_minor
  fi
}

function prepare_deploy_no_tags () {
  if [ -z $4 ] ; then
    echo "Usage: prepare_deploy <branch> <old-minor> <new-minor> <commits to cherry-pick>"
    echo "example: prepare_deploy 5.1 4.0.23-0 4.0.24-0 ffed896 a1d6efa"
  else
    branch="$1"
    shift
    old_minor="$1"
    shift
    new_minor="$1"
    shift
    echo ""
    echo ➜ git checkout $branch
    git checkout $branch
    echo ""
    echo ➜ git pull
    git pull
    echo ""
    echo ➜ git cherry-pick -x $*
    git cherry-pick -x $*
    if [ $? -eq 0 ] ; then
      echo ""
      echo ➜ change_versions $branch-$old_minor $branch-$new_minor
      /Users/antoine/bin/change_versions $branch-$old_minor $branch-$new_minor
      echo ""
      echo ➜ git commit -a -m "Bump version number to $branch-$new_minor"
      git commit -a -m "Bump version number to $branch-$new_minor"
      echo ""
      echo ➜ git push origin $branch
      git push origin $branch
    else
      echo "git cherry-pick exited with status $?"
    fi
  fi
}
