#!/usr/bin/env bats

PROXY_URL=http://127.0.0.1:8081/

@test "the root URL should redirect to Blue Ocean" {
    run curl -Iv ${PROXY_URL}
    [ "${status}" -eq 0 ]
    echo ${output} | grep -e "Location: http://.*/blue/pipelines"
}

@test "/newJob redirects to the Blue Ocean 'Create Pipeline' view" {
    run curl -Iv ${PROXY_URL}/newJob
    [ "${status}" -eq 0 ]
    echo ${output} | grep -e "Location: http://.*/blue/organizations/jenkins/create-pipeline"
}

@test "/cli redirects to the Abuse page" {
    run curl -Iv ${PROXY_URL}/cli
    [ "${status}" -eq 0 ]
    echo ${output} | grep -e "Location: https://codevalet.io/abuse/"
}

@test "/asynchPeople redirects to the Abuse page" {
    run curl -Iv ${PROXY_URL}/asynchPeople
    [ "${status}" -eq 0 ]
    echo ${output} | grep -e "Location: https://codevalet.io/abuse/"
}

@test "/api redirects to the Abuse page" {
    run curl -Iv ${PROXY_URL}/api
    [ "${status}" -eq 0 ]
    echo ${output} | grep -e "Location: https://codevalet.io/abuse/"
}

@test "/api/json redirects to the Abuse page" {
    run curl -Iv ${PROXY_URL}/api/json
    [ "${status}" -eq 0 ]
    echo ${output} | grep -e "Location: https://codevalet.io/abuse/"
}

@test "/job/something/api redirects to the Abuse page" {
    run curl -Iv ${PROXY_URL}/job/codevalet/api
    [ "${status}" -eq 0 ]
    echo ${output} | grep -e "Location: https://codevalet.io/abuse/"
}

@test "/job/something/api/json redirects to the Abuse page" {
    run curl -Iv ${PROXY_URL}/job/codevalet/api/json
    [ "${status}" -eq 0 ]
    echo ${output} | grep -e "Location: https://codevalet.io/abuse/"
}
