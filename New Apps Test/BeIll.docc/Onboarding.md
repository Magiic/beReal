# Onboarding

For the first time, an onboarding is displaying. There is few screens to make sure that the user understand the app and use the core feature immediately.

## Overview

``AppOnboardingView`` contains multiple steps and screens to completed. Below screens.

### Screens

@Row {
    @Column {
        ``AppOnboardingResumeView`` This is the first screen user see. 
    }
    @Column {
        ![Tell a story to engage user](onboarding1)
    }
}

@Row {
    @Column {
        ``AppOnboardingUserInfoView`` to get information user such as email.
    }
    @Column {
        ![Tell a story to engage user](onboarding2)
    }
}

@Row {
    @Column {
        ``AppOnboardingPhotoPickView`` to select a photo from library.
    }
    @Column {
        ![Tell a story to engage user](onboarding3)
    }
}

@Row {
    @Column {
        ``AppOnboardingPhotoFilteredView`` get the result of the photo selected edited by a filter.
    }
    @Column {
        ![Tell a story to engage user](onboarding4)
    }
}
