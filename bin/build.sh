#!/bin/bash

carthage checkout
mv Carthage/Checkouts/reddift/reddiftTests/test_config.json{.sample,}
carthage build --platform ios
