#!/bin/bash -xe

FAILED_TESTS=""

check_return_code() {
  code=$1
  test_name=$2
  if [ $code -ne 0 ]; then
    FAILED_TESTS+="${test_name} syntax is wrong; "
  fi
}

echo "Checking shellcheck..."
sudo apt-get install shellcheck
shellcheck_status=0
for file in $(find -exec . -name "*.sh"); do
  shellcheck $file -e SC2086,SC2016,SC2034,SC2046,SC2140
  shellcheck_status=$(( shellcheck_status + $? ))
done
echo check_return_code $shellcheck_status "shellcheck"
echo "Done"

echo "Checking bash syntax..."
bash_status=0
for file in $(find -exec . -name "*.sh"); do
  bash -n $file
  bash_status=$(( bash_status + $? ))
done
check_return_code $bash_status "Bash"
echo "Done"

echo "Checking travis ci syntax..."
travis_status=0
for file in $(find -exec . -name "*.sh"); do
  gem install travis -f --no-rdoc --no-ri
  echo "y" | travis lint -x
  travis_status=$(( travis_status + $? ))
done
check_return_code $travis_status "travis CI"
echo "Done"

if [ -n "$FAILED_TESTS" ]; then
   echo "$FAILED_TESTS"
   exit 1
else
   echo "Syntax checks passed"
   exit 0
fi
