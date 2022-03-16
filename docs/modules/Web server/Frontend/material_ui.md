# MUI

We use MUI to organise the styling of the app more easier. MUI is the React UI library, which provides foundational and advanced components.

## Theme

One of the feature of MUI is theme. Theme can be defined by basic object with required styling and then passed to `createTheme` fuction. MUI provides the default set of styling and we overrode part of them in file `Utils/Theme.js`.

In theme palette, we defined two main colors for the whole app, called primary and secondary. The rest of the colors is keeped untouched and can be accessed through name: error, warning, info, success. The resulting palette is defined as follows:

| Primary  |   |   |
|---|---|---|
| <span style="color:#009688">main #009688</span> | <span style="color:#b2dfdb">light #b2dfdb</span> | <span style="color:#004d40">dark #004d40</span>|

| Secondary  |   |   |
|---|---|---|
| <span style="color:#757575">main #757575</span> | <span style="color:#f5f5f5">light #f5f5f5</span> | <span style="color:#212121">dark #212121</span>|


We did a little updates on font size as well.