#!/bin/bash

carthage checkout
mv ~/build/achan/Noosh/Carthage/Checkouts/reddift/test/test_config.json{.sample,}
mv ~/build/achan/Noosh/Carthage/Checkouts/reddift/application/reddift_config.json{.sample,}
ls -al  ~/build/achan/Noosh/Carthage/Checkouts/reddift/test/test_config.json{.sample,}
ls -al  ~/build/achan/Noosh/Carthage/Checkouts/reddift/application/reddift_config.json{.sample,}
carthage build --platform ios
