# Getting Started

## Description

This app applies filters to a photo selected by the user. This photo must contain a face to work. It will apply different filters like making the nose bigger or applying black point skin.

![Illustration person sick](illustration.jpeg)

> You need a device to run the application.

## Global Information

- Application is available in landscape mode
- Application run only on device
- Minimum deployment target iOS 16
- Minimum tests was added
- Application is localized in English & French
- Available in light and dark mode.

## Features

Here some details about features I implemented.

### Onboarding

When running the app for the first time, an onboarding let you engage in the story.

1. Select a picture with a face
2. See the result of the face edited with filters

### History

- See all photos effects realised previously
- You can create new one by tap the "+" button

### Create new photo effect

- Same step that viewed in onboarding but this time at the end a button let you buy new filters

### Paywall

A place to buy new filters and make us billionnaire.

## Technical Decision

I use swiftUI because the app was created first in swiftUI.

I created local package for code that can be isolated from the app target. Features should be also have their dedicated modules but I missing time to properly do it.

I use dependency injection via init or @Environment swiftui to show possible ways to inject dependencies.

I created analytics for some views/features because in production app, it a must have.

I created an ``AppLogger`` to log events. I didn't use much here but it is useful to get logs from production. The logs I used are mostly for errors.

### Tests

- UITests: I used Robot architecture to develop UITest happy path for Onboarding funnel
- Units Tests: I developped tests for ``EmailValidator`` and ``AppOnboardingViewModel``.

Test Plan: I created 3 tests plans:

- UnitTestPlan: Run Unit Tests only
- UITestPlan: Run UITests only
- ALLTestsPlan: Run all tests

### Architecture

I used local packages to isolate the code from the application target. Ideally, it is better to isolate features in their module and reuse them through other feature modules when needed.

Some views are pairing with a view model to isolate logic view code and test if needed.

## Topics

### Onboarding

- <doc:Onboarding>
- ``AppOnboardingView``

### History

- ``IllHistoryView``
- ``IllCheckView``

### Paywall

- ``PaywallView``
