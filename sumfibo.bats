setup() {
    load 'bats/bats-support/load'
    load 'bats/bats-assert/load'
}

# Normal usage
# ------------

@test "./sumfibo 0" {
    run ./sumfibo 0
    assert_output 0
    assert_success
}

@test "./sumfibo 1" {
    run ./sumfibo 1
    assert_output 1
    assert_success
}

@test "./sumfibo 2" {
    run ./sumfibo 2
    assert_output 2
    assert_success
}

@test "./sumfibo 10" {
    run ./sumfibo 10
    assert_output 143
    assert_success
}

@test "./sumfibo 19" {
    run ./sumfibo 19
    assert_output 10945
    assert_success
}

@test "./sumfibo 20" {
    run ./sumfibo 20
    assert_output 17710
    assert_success
}

# Errors
# ------

@test "./sumfibo with no argument" {
    run ./sumfibo
    assert_output 'error: Exactly one argument must be provided'
    assert_failure 1
}

@test "./sumfibo a" {
    run ./sumfibo a
    assert_output 'error: The argument must be an integer between 0 and 20'
    assert_failure 1
}

@test "./sumfibo -1" {
    run ./sumfibo -1
    assert_output 'error: The argument must be an integer between 0 and 20'
    assert_failure 1
}

@test "./sumfibo 21" {
    run ./sumfibo 21
    assert_output 'error: The argument must be an integer between 0 and 20'
    assert_failure 1
}

