This package is a static Qt patched and used in net-im/telegram.

The reason for splitting it was to improve maintainability and compilation speeds,
because the patch for Qt is rarely changed and thus Qt doesn't need to be recompiled everytime Telegram
has a new release.
