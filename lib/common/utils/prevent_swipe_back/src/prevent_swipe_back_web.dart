import 'dart:js' as js;

void preventSwipeBack() {
  js.context.callMethod("eval", [
    """
    document.addEventListener("wheel", function(e) {
       if (e.shiftKey || e.deltaX !== 0 {
          e.preventDefault();
       }
    }, { passive: false });
    """
  ]);
}
