//
//  MaterialTextField.swift
//  MaterialTextField
//
//  Created by José Victor Pereira Costa on 21/04/2018.
//  Copyright © 2018 Zup IT. All rights reserved.
//
import UIKit

protocol MaterialTextFieldDelegate {
    
    /// identify touch gesture
    func wasTouched()
    
    //identify changes on the responder
    func returnKeyWasPressed()
}

@IBDesignable
class JVMaterialText: UITextField {
    
    @IBInspectable dynamic open var disabledColor: UIColor = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1) {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable dynamic open var enabledColor: UIColor = UIColor(red: 32/255, green: 178/255, blue: 187/255, alpha: 1) {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable dynamic open var placeHolderColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1) {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable dynamic open var floatingLabelColor: UIColor = UIColor(red: 109/255, green: 109/255, blue: 109/255, alpha: 1) {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable dynamic open var errorColor: UIColor = UIColor(red: 248/255, green: 130/255, blue: 0/255, alpha: 1) {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable dynamic open var placeHolderFont: UIFont = UIFont.systemFont(ofSize: 13) {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable open var floatingPlaceHolder: String = " " {
        didSet {
            setNeedsDisplay()
            updatePlaceHolderText()
        }
    }
    @IBInspectable open var errorMessage: String = " " {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable open var iconRightImage: UIImage = UIImage() {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable open var hasIcon: Bool = false {
        didSet {
            setNeedsLayout()
            imageSize = hasIcon ? placeHolderFont.lineHeight : 0
        }
    }
    
    public var hasError = false {
        didSet {
            presenteError()
        }
    }
    open var borderLine: UIView!
    open var placeHolderLabel: UILabel = UILabel()
    open var rightImage: UIImageView!
    open var onTop = false
    open var isVisible = false
    open var placeHolderheight: CGFloat = 16
    open var imageSize: CGFloat = 0
    open var hasImage = false
    var verifyDelegate: MaterialTextFieldDelegate?
    
    
    /// update the colors acording to the textfield state
    func updateColors() {
        if !isEditing && !hasText && !hasError {
            borderLine.backgroundColor = disabledColor
            placeHolderLabel.textColor = placeHolderColor
        }
        else if hasText || isEditing {
            
            if !hasText && !hasError {
                borderLine.backgroundColor = enabledColor
                placeHolderLabel.textColor = floatingLabelColor
            }
            else if hasError {
                borderLine.backgroundColor = errorColor
                placeHolderLabel.textColor = errorColor
            }
            else {
                borderLine.backgroundColor = enabledColor
                placeHolderLabel.textColor = floatingLabelColor
            }
        }
    }
    
    
    /// set error message on place rolder if has error
    func presenteError() {
        placeHolderLabel.text = hasError ? errorMessage : floatingPlaceHolder
    }
    
    /// init textfield place holder color
    func initPlaceHolderColor() {
        attributedPlaceholder = NSAttributedString(string: placeholder!, attributes: [NSAttributedStringKey.foregroundColor: placeHolderColor, NSAttributedStringKey.font: font as Any])
    }
    
    /// update placeholderlabel text
    func updatePlaceHolderText() {
        placeHolderLabel.text = floatingPlaceHolder
        placeholder = floatingPlaceHolder
        initErrorMassage()
    }
    
    /// instantiate border line
    func instantiateBorderLine() {
        borderLine = UIView()
        borderLine.isUserInteractionEnabled = false
        borderLine.frame = drawBorderLine(bounds)
        borderLine.backgroundColor = disabledColor
        borderLine.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        addSubview(borderLine)
    }
    
    /// instatntiate label
    func instantiateLabel() {
        placeHolderLabel = UILabel()
        placeHolderLabel.alpha = 0.0
        placeHolderLabel.font = placeHolderFont
        placeHolderLabel.textColor = floatingLabelColor
        placeHolderLabel.textAlignment = .center
        placeHolderLabel.isUserInteractionEnabled = false
        placeHolderLabel.text = floatingPlaceHolder
        placeHolderLabel.autoresizingMask = [.flexibleHeight]
        addSubview(placeHolderLabel)
    }
    
    /// instantiate right image
    func instantiateRightImage() {
        let iconImageView = UIImageView()
        iconImageView.backgroundColor = .clear
        iconImageView.contentMode = .center
        iconImageView.autoresizingMask = [.flexibleTopMargin, .flexibleRightMargin]
        iconImageView.frame = drawRightImage(bounds)
        iconImageView.image = updateImage()
        rightImage = iconImageView
        addSubview(rightImage)
    }
    
    /// update placeholderlabel frame and visibility
    func updatePlaceHolder() {
        placeHolderLabel.frame = drawPlaceHolderLabel(bounds)
        placeHolderLabel.alpha =  isVisible ? 1.0: 0.0
    }
    
    /// update border line
    func updateBorderLine() {
        borderLine.frame = drawBorderLine(bounds)
    }
    
    /// update rightImage frame and image
    func updateRightImage() {
        rightImage.frame = drawRightImage(bounds)
        rightImage.image = updateImage()
    }
    
    // set image if textfield has icon
    func updateImage() -> UIImage {
        return hasIcon ? iconRightImage : UIImage()
    }
    
    /// init place holder and update property of the screen elements
    func releaseScreen() {
        initPlaceHolderColor()
        updateColors()
        updateRightImage()
    }
    
    // register notification events un textfield
    func registerNotifications() {
        self.addTarget(self, action: #selector(JVMaterialText.touch), for: UIControlEvents.editingDidBegin)
        self.addTarget(self, action: #selector(JVMaterialText.onTextChanged), for: UIControlEvents.editingDidBegin)
        self.addTarget(self, action: #selector(JVMaterialText.onTextChanged), for: UIControlEvents.editingDidEnd)
    }
    
    /// notify delegate object on textfield touch
    @objc func touch() {
        if let vdelegate = verifyDelegate {
            vdelegate.wasTouched()
        }
    }
    
    /// set the cange on the textfield propertys e call animate function (animate label)
    @objc func onTextChanged() {
        var opacity: CGFloat = 1.0
        var yPlalceHolder: CGFloat = 0
        
        if !isEditing && onTop && !hasText {
            opacity = 0.0
            
            if let myfont = font {
                yPlalceHolder = myfont.lineHeight
            }
            else{
                yPlalceHolder = placeHolderheight
            }
            onTop = !onTop
            isVisible = !isVisible
            animateLabel(opacity, yPlalceHolder)
        }
        else if (isEditing && !onTop) {
            onTop = !onTop
            isVisible = !isVisible
            animateLabel(opacity, yPlalceHolder)
        }
    }
    
    // execute animation if necessary
    func animateLabel(_ opacity: CGFloat,_ yPlalceHolder: CGFloat) {
        let frame = CGRect(x: 0, y: yPlalceHolder, width: bounds.size.width, height: placeHolderFont.lineHeight)
        placeholder = " "
        UIView.animate(withDuration: 0.25 , delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.placeHolderLabel.alpha = opacity
            self.placeHolderLabel.frame = frame
        },
                       completion: { _ in
                        if !self.onTop {
                            self.placeholder = self.floatingPlaceHolder
                            self.placeHolderLabel.text = self.floatingPlaceHolder
                        }
        })
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        let textfield = super.editingRect(forBounds: bounds)
        let rect = CGRect(x: textfield.origin.x, y: placeHolderFont.lineHeight, width: textfield.size.width - imageSize, height: textfield.size.height - placeHolderLabel.font.lineHeight - 2)
        return rect
    }
    
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        if let myfont = font {
            return CGRect(x: 0, y: myfont.lineHeight, width: bounds.size.width - imageSize, height: bounds.size.height - 2 - myfont.lineHeight)
        }
        return CGRect(x: 0 , y: placeHolderheight , width: bounds.size.width - imageSize, height: bounds.size.height - placeHolderheight - 2)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let textfield = super.editingRect(forBounds: bounds)
        if let myfont = font {
            return CGRect(x: textfield.origin.x, y: bounds.size.height - 2 - myfont.lineHeight, width: textfield.size.width - imageSize, height: textfield.size.height - myfont.lineHeight - 2)
        }
        return CGRect(x: textfield.origin.x, y: bounds.size.height - 2 - placeHolderheight, width: textfield.size.width - imageSize, height: placeHolderheight - 2)
    }
    
    
    /// drawn placeholderlabel
    ///
    /// - Parameter bounds: textfield bounds
    /// - Returns: placeholderlabel rect
    func drawPlaceHolderLabel(_ bounds: CGRect) -> CGRect {
        
        if isVisible {
            onTop = true
            return CGRect(x: 0, y: 0, width: bounds.size.width - imageSize, height: placeHolderFont.lineHeight)
        }
        return CGRect(x: 0, y: bounds.size.height - 2 - placeHolderFont.lineHeight , width: bounds.size.width - imageSize, height: placeHolderFont.lineHeight)
    }
    
    /// drawn rightImage view rect
    ///
    /// - Parameter bounds: textfield bounds
    /// - Returns: rightImage view rect
    func drawRightImage(_ bounds: CGRect) -> CGRect {
        if let myfont = font {
            return CGRect(x:bounds.size.width - imageSize, y: myfont.lineHeight, width: imageSize, height: imageSize)
        }
        
        return CGRect(x: 0 , y: placeHolderheight , width: imageSize, height: imageSize)
    }
    
    /// drawn border line rect
    ///
    /// - Parameter bounds: textfield bounds
    /// - Returns: return the borderline rect
    func drawBorderLine(_ bounds: CGRect) -> CGRect {
        
        if #available(iOS 9.0, *) {
            if isFocused || isEditing {
                return CGRect(x: 0, y: bounds.size.height - 2, width: bounds.size.width, height: 2)
            }
        } else {
            if isEditing {
                return CGRect(x: 0, y: bounds.size.height - 2, width: bounds.size.width, height: 2)
            }
        }
        return CGRect(x: 0, y: bounds.size.height - 1, width: bounds.size.width, height: 1)
    }
    
    /// set placeholder or placeHolderLabel if somone is empty
    func setFloatingPlaceHolder() {
        
        if let ph = placeholder {
            floatingPlaceHolder = ph
        }
        else{
            placeholder = floatingPlaceHolder
        }
        initErrorMassage()
    }
    
    /// init errorMessage
    func initErrorMassage() {
        if errorMessage == " " {
            errorMessage = floatingPlaceHolder
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setFloatingPlaceHolder()
        instantiateBorderLine()
        instantiateLabel()
        instantiateRightImage()
        borderStyle = .none
        registerNotifications()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setFloatingPlaceHolder()
        instantiateBorderLine()
        instantiateLabel()
        instantiateRightImage()
        borderStyle = .none
        registerNotifications()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        releaseScreen()
        updatePlaceHolder()
        updateBorderLine()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setFloatingPlaceHolder()
        instantiateBorderLine()
        instantiateLabel()
        instantiateRightImage()
        borderStyle = .none
    }
    
    override func becomeFirstResponder() -> Bool {
        
        let becomeFR = super.becomeFirstResponder()
        releaseScreen()
        if let vdeleggate = verifyDelegate {
            vdeleggate.returnKeyWasPressed()
        }
        return becomeFR
    }
    
    override func resignFirstResponder() -> Bool {
        
        let resignFR = super.resignFirstResponder()
        releaseScreen()
        if let vdeleggate = verifyDelegate {
            vdeleggate.returnKeyWasPressed()
        }
        return resignFR
    }
    
    // recover the textfield state
    func recoverState(state: Bool, content: String) {
        hasError = state
        isVisible =  content.count > 0 ? true : false
        updateColors()
        text = content
        updatePlaceHolder()
    }
}

// MARK: - UITextFieldDelegate
