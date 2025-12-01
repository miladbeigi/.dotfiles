#!/bin/bash

# This script provides a set of tools for working with Git repositories.

# Config worktree repository to pull remote branches
function config_worktree() {
    git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*" 
}
