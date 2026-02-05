#!/usr/bin/env bash
#
# Absolute life saver script for Logi MX keyboard users on macOS.
# For typing special characters with an international keyboard layout,
# you need the right Opt key, which is reachable only with the pinky
# on the Logi MX macOS layout. This script swaps right Cmd (which is
# right Alt on Windows) and right Opt.
#
# To apply the fix on boot, add it as a login item in the system Preferences.
#
# Cudos to https://gist.github.com/dkoprowski/4c6cd49343792ce38ed839d382add22a
# for this fix!
#

hidutil property --set '{
  "UserKeyMapping": [
    {
      "HIDKeyboardModifierMappingSrc": 0x7000000e7,
      "HIDKeyboardModifierMappingDst": 0x7000000e6
    },
    {
      "HIDKeyboardModifierMappingSrc": 0x7000000e6,
      "HIDKeyboardModifierMappingDst": 0x7000000e7
    }
  ]
}'

