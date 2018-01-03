#!/usr/bin/env groovy
/*
 * Set up the basic GitHub OAuth permissions for this instance
 */

if (System.env.get('SUPER_DANGEROUS_LOCAL_ONLY_DISABLE_AUTH')) {
    return
}

import jenkins.model.*
import hudson.security.*
import hudson.model.Item
import org.jenkinsci.plugins.workflow.cps.replay.ReplayAction
import org.jenkinsci.plugins.GithubAuthorizationStrategy
import org.jenkinsci.plugins.GithubSecurityRealm

def authorization = new GlobalMatrixAuthorizationStrategy()
authorization.add(Jenkins.READ, 'Anonymous')
authorization.add(Item.READ, 'Anonymous')
authorization.add(Jenkins.ADMINISTER, 'rtyler')

[
    Jenkins.READ,
    Item.BUILD,
    Item.CANCEL,
    Item.CONFIGURE,
    Item.CREATE,
    Item.DELETE,
    Item.DISCOVER,
    Item.READ,
    ReplayAction.REPLAY,
].each { permission ->
    authorization.add(permission, System.env.get('GITHUB_USER') ?: 'rtyler')
}


def realm = new GithubSecurityRealm('https://github.com',           /* GitHub web URI */
                                    'https://api.github.com',       /* GitHub API URI */
                                    System.env.get('CLIENT_ID') ?: '4e76a9546e5633505ebe',         /* OAuth Client ID */
                                    System.env.get('CLIENT_SECRET') ?: '3231316e75b5dace3e8e41d8e5367256959c846a',/* OAuth Client Secret */
                                    'read:public_repo,user:email'           /* OAuth permission scopes */
                                    )
Jenkins.instance.authorizationStrategy = authorization
Jenkins.instance.securityRealm = realm
Jenkins.instance.save()
