#!/usr/bin/env groovy

/* Disable Scripted Pipeline support via the Restricted Declarative plugin */

io.jenkins.plugins.restricteddeclarative.GlobalRestrictedConfig.get().setRestricted(true)
