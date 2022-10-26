#!/usr/bin/env python3

import asyncio
import iterm2
import os
import subprocess
import sys

#def make_title(auto_name, profile_name):
#    if auto_name != profile_name:
#        return auto_name
#        #return profile_name + ': ' + auto_name
#    else:
#        #return ""
#        return profile_name

#def make_git(git_info):
#    if git_info:
#        return git_info
#    return ""

async def main(connection):
    @iterm2.TitleProviderRPC
    async def my_title(
            auto_name=iterm2.Reference("autoName?"),
            #profile_name=iterm2.Reference("profileName?"),
            job_name=iterm2.Reference("jobName?"),
            git_info=iterm2.Reference("user.gitLine?")):
        if git_info:
            return git_info
        return auto_name + " (" + job_name + ")"
        #return make_title(auto_name, profile_name) + " (" + job_name + ")"
        #parts = [make_title(auto_name, profile_name), make_git(git_info)]
        #return " ".join(list(filter(lambda x: x, parts)))
    await my_title.async_register(
            connection,
            display_name="Session/job or Git Repo/Branch",
            unique_identifier="com.iterm2.example.dhakimian-title")

iterm2.run_forever(main)
