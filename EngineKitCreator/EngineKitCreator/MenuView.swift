
import UIKit


enum Orientation {
    case Horizontal
    case Vertical
}


let fromViewMargin: CGFloat = 10
let edgesMargin: CGFloat = 2 * fromViewMargin
let totalMargin = fromViewMargin + edgesMargin


class MenuView: UIView {

    convenience init(fromView: UIView, inView: UIView) {

        let availableWidth = inView.frame.size.width
        let availableHeight = inView.frame.size.height

        let fromViewFrame = inView.convertRect(fromView.frame,
                                               fromView: fromView.superview)
        let fromViewOrigin = fromViewFrame.origin
        let fromViewSize = fromViewFrame.size

        let availableUp = fromViewOrigin.y
        let availableDown = availableHeight - fromViewOrigin.y - fromViewSize.height
        let availableLeft = fromViewOrigin.x
        let availableRight = availableWidth - fromViewOrigin.x - fromViewSize.width

        let originX: CGFloat
        let originY: CGFloat
        let availableX: CGFloat
        let availableY: CGFloat

        if (availableLeft > availableRight) {
            originX = edgesMargin
            availableX = availableLeft - totalMargin
        } else {
            originX = availableWidth - availableRight + fromViewMargin
            availableX = availableWidth - originX - edgesMargin
        }

        if (availableUp > availableDown) {
            originY = edgesMargin
            availableY = availableUp - totalMargin
        } else {
            originY = availableHeight - availableDown + fromViewMargin
            availableY = availableHeight - originY - edgesMargin
        }

        self.init(frame: CGRectMake(originX, originY, availableX, availableY))

        self.backgroundColor = UIColor.greenColor()
    }

    convenience init(fromView: UIView, inView: UIView, orientation: Orientation) {

        self.init(fromView: fromView, inView: inView)

        let availableWidth = inView.frame.size.width
        let availableHeight = inView.frame.size.height

        let originX: CGFloat
        let originY: CGFloat
        let availableX: CGFloat
        let availableY: CGFloat

        if (orientation == .Horizontal) {
            originY = edgesMargin
            availableY = availableHeight - totalMargin
            originX = self.frame.origin.x
            availableX = self.frame.size.width
        }
        else {
            originX = edgesMargin
            availableX = availableWidth - totalMargin
            originY = self.frame.origin.y
            availableY = self.frame.size.height
        }

        self.frame = CGRectMake(originX, originY, availableX, availableY)
    }

    /**
    * Initializes the MenuView to be anchored to the @p fromView, to fit inside 
    * the @p inView, to have a certain @p Orientation (ie to be @b below or 
    * @b beside the @p fromView) and to have a certain @p sizeRatio between its
    * own size and the @p inView's size.
    * The @p fromView is typically the button that caused the menuView to 
    * appear; the @p inView, the @p menuView's container; and the @p sizeRatio 
    * can be about 0.3, so that the @p menuView doesn't cover the whole
    * @p inView.
    */
    convenience init(fromView: UIView, inView: UIView, orientation: Orientation, sizeRatio: CGFloat) {
        self.init(fromView: fromView, inView: inView, orientation: orientation)

        var start: CGFloat
        var finish: CGFloat
        let center: CGFloat
        let newSize: CGFloat

        if (orientation == .Horizontal) {
            start = self.frame.origin.y
            finish = start + self.frame.size.height

            center = (start + finish) / 2

            newSize = self.frame.size.height * sizeRatio

            start = center - newSize/2
            finish = center + newSize/2

            let fromViewFrame = inView.convertRect(fromView.frame,
                fromView: fromView.superview)
            let fromViewStart = fromViewFrame.origin.y
            let fromViewFinish = fromViewFrame.origin.y + fromViewFrame.size.height

            if (start > fromViewStart) {
                start = fromViewStart
            }
            else if (finish < fromViewFinish) {
                finish = fromViewFinish
            }

            self.frame = CGRectMake(self.frame.origin.x, start, self.frame.size.width, finish - start)
        }
        else {
            start = self.frame.origin.x
            finish = start + self.frame.size.width

            center = (start + finish) / 2

            newSize = self.frame.size.width * sizeRatio

            start = center - newSize/2
            finish = center + newSize/2

            let fromViewFrame = inView.convertRect(fromView.frame,
                fromView: fromView.superview)
            let fromViewStart = fromViewFrame.origin.x
            let fromViewFinish = fromViewFrame.origin.x + fromViewFrame.size.width

            if (start > fromViewStart) {
                start = fromViewStart
            }
            else if (finish < fromViewFinish) {
                finish = fromViewFinish
            }

            self.frame = CGRectMake(start, self.frame.origin.y, finish - start, self.frame.size.width)
        }

    }

}
