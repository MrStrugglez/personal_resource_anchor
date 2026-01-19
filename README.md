# Personal Resource Anchor

World of Warcraft addon that anchors EssentialCooldownViewer and UtilityCooldownViewer to the Personal Resource Display.

## Description

This addon automatically anchors two cooldown viewer frames to your Personal Resource Display (NamePlate1) when you log in:
- **EssentialCooldownViewer**: Anchored directly below the Personal Resource Display
- **UtilityCooldownViewer**: Anchored below the EssentialCooldownViewer

The anchoring uses center-bottom to center-top alignment with appropriate spacing.

## Installation

1. Download the addon
2. Extract the `PersonalResourceAnchor` folder to your `World of Warcraft\_retail_\Interface\AddOns\` directory
3. Restart World of Warcraft or reload the UI with `/reload`

## Usage

The addon works automatically on login. The cooldown viewers will be anchored to the Personal Resource Display once all frames are loaded.

## Features

- Automatic anchoring on player login
- Informative console messages for debugging
- Fallback positioning if frames are not found

## Requirements

- World of Warcraft Retail (Interface version 110002 or compatible)
- EssentialCooldownViewer addon (optional, will show warning if not found)
- UtilityCooldownViewer addon (optional, will show warning if not found)

## License

See LICENSE file for details.
