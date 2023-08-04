// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal static let accentColor = ColorAsset(name: "AccentColor")
  internal enum Colors {
    internal static let accentBlue = ColorAsset(name: "colors/accentBlue")
    internal static let black = ColorAsset(name: "colors/black")
    internal static let coral = ColorAsset(name: "colors/coral")
    internal static let grey = ColorAsset(name: "colors/grey")
    internal static let lightGrey = ColorAsset(name: "colors/lightGrey")
    internal static let mouseGrey = ColorAsset(name: "colors/mouseGrey")
    internal static let neutralGray = ColorAsset(name: "colors/neutralGray")
    internal static let paleGrey = ColorAsset(name: "colors/paleGrey")
    internal static let systemGray = ColorAsset(name: "colors/systemGray")
    internal static let white = ColorAsset(name: "colors/white")
  }
  internal enum Flags {
    internal static let ad = ImageAsset(name: "flags/AD")
    internal static let ae = ImageAsset(name: "flags/AE")
    internal static let af = ImageAsset(name: "flags/AF")
    internal static let ag = ImageAsset(name: "flags/AG")
    internal static let ai = ImageAsset(name: "flags/AI")
    internal static let al = ImageAsset(name: "flags/AL")
    internal static let am = ImageAsset(name: "flags/AM")
    internal static let ao = ImageAsset(name: "flags/AO")
    internal static let aq = ImageAsset(name: "flags/AQ")
    internal static let ar = ImageAsset(name: "flags/AR")
    internal static let `as` = ImageAsset(name: "flags/AS")
    internal static let at = ImageAsset(name: "flags/AT")
    internal static let au = ImageAsset(name: "flags/AU")
    internal static let aw = ImageAsset(name: "flags/AW")
    internal static let ax = ImageAsset(name: "flags/AX")
    internal static let az = ImageAsset(name: "flags/AZ")
    internal static let ba = ImageAsset(name: "flags/BA")
    internal static let bb = ImageAsset(name: "flags/BB")
    internal static let bd = ImageAsset(name: "flags/BD")
    internal static let be = ImageAsset(name: "flags/BE")
    internal static let bf = ImageAsset(name: "flags/BF")
    internal static let bg = ImageAsset(name: "flags/BG")
    internal static let bh = ImageAsset(name: "flags/BH")
    internal static let bi = ImageAsset(name: "flags/BI")
    internal static let bj = ImageAsset(name: "flags/BJ")
    internal static let bl = ImageAsset(name: "flags/BL")
    internal static let bm = ImageAsset(name: "flags/BM")
    internal static let bn = ImageAsset(name: "flags/BN")
    internal static let bo = ImageAsset(name: "flags/BO")
    internal static let bqBo = ImageAsset(name: "flags/BQ-BO")
    internal static let bqSa = ImageAsset(name: "flags/BQ-SA")
    internal static let bqSe = ImageAsset(name: "flags/BQ-SE")
    internal static let br = ImageAsset(name: "flags/BR")
    internal static let bs = ImageAsset(name: "flags/BS")
    internal static let bt = ImageAsset(name: "flags/BT")
    internal static let bv = ImageAsset(name: "flags/BV")
    internal static let bw = ImageAsset(name: "flags/BW")
    internal static let by = ImageAsset(name: "flags/BY")
    internal static let bz = ImageAsset(name: "flags/BZ")
    internal static let ca = ImageAsset(name: "flags/CA")
    internal static let cc = ImageAsset(name: "flags/CC")
    internal static let cd = ImageAsset(name: "flags/CD")
    internal static let cf = ImageAsset(name: "flags/CF")
    internal static let cg = ImageAsset(name: "flags/CG")
    internal static let ch = ImageAsset(name: "flags/CH")
    internal static let ci = ImageAsset(name: "flags/CI")
    internal static let ck = ImageAsset(name: "flags/CK")
    internal static let cl = ImageAsset(name: "flags/CL")
    internal static let cm = ImageAsset(name: "flags/CM")
    internal static let cn = ImageAsset(name: "flags/CN")
    internal static let co = ImageAsset(name: "flags/CO")
    internal static let cr = ImageAsset(name: "flags/CR")
    internal static let cu = ImageAsset(name: "flags/CU")
    internal static let cv = ImageAsset(name: "flags/CV")
    internal static let cw = ImageAsset(name: "flags/CW")
    internal static let cx = ImageAsset(name: "flags/CX")
    internal static let cy = ImageAsset(name: "flags/CY")
    internal static let cz = ImageAsset(name: "flags/CZ")
    internal static let de = ImageAsset(name: "flags/DE")
    internal static let dj = ImageAsset(name: "flags/DJ")
    internal static let dk = ImageAsset(name: "flags/DK")
    internal static let dm = ImageAsset(name: "flags/DM")
    internal static let `do` = ImageAsset(name: "flags/DO")
    internal static let dz = ImageAsset(name: "flags/DZ")
    internal static let ec = ImageAsset(name: "flags/EC")
    internal static let ee = ImageAsset(name: "flags/EE")
    internal static let eg = ImageAsset(name: "flags/EG")
    internal static let eh = ImageAsset(name: "flags/EH")
    internal static let er = ImageAsset(name: "flags/ER")
    internal static let es = ImageAsset(name: "flags/ES")
    internal static let et = ImageAsset(name: "flags/ET")
    internal static let fi = ImageAsset(name: "flags/FI")
    internal static let fj = ImageAsset(name: "flags/FJ")
    internal static let fk = ImageAsset(name: "flags/FK")
    internal static let fm = ImageAsset(name: "flags/FM")
    internal static let fo = ImageAsset(name: "flags/FO")
    internal static let fr = ImageAsset(name: "flags/FR")
    internal static let ga = ImageAsset(name: "flags/GA")
    internal static let gbNir = ImageAsset(name: "flags/GB-NIR")
    internal static let gbSct = ImageAsset(name: "flags/GB-SCT")
    internal static let gbWls = ImageAsset(name: "flags/GB-WLS")
    internal static let gb = ImageAsset(name: "flags/GB")
    internal static let gd = ImageAsset(name: "flags/GD")
    internal static let ge = ImageAsset(name: "flags/GE")
    internal static let gf = ImageAsset(name: "flags/GF")
    internal static let gg = ImageAsset(name: "flags/GG")
    internal static let gh = ImageAsset(name: "flags/GH")
    internal static let gi = ImageAsset(name: "flags/GI")
    internal static let gl = ImageAsset(name: "flags/GL")
    internal static let gm = ImageAsset(name: "flags/GM")
    internal static let gn = ImageAsset(name: "flags/GN")
    internal static let gp = ImageAsset(name: "flags/GP")
    internal static let gq = ImageAsset(name: "flags/GQ")
    internal static let gr = ImageAsset(name: "flags/GR")
    internal static let gs = ImageAsset(name: "flags/GS")
    internal static let gt = ImageAsset(name: "flags/GT")
    internal static let gu = ImageAsset(name: "flags/GU")
    internal static let gw = ImageAsset(name: "flags/GW")
    internal static let gy = ImageAsset(name: "flags/GY")
    internal static let hk = ImageAsset(name: "flags/HK")
    internal static let hm = ImageAsset(name: "flags/HM")
    internal static let hn = ImageAsset(name: "flags/HN")
    internal static let hr = ImageAsset(name: "flags/HR")
    internal static let ht = ImageAsset(name: "flags/HT")
    internal static let hu = ImageAsset(name: "flags/HU")
    internal static let id = ImageAsset(name: "flags/ID")
    internal static let ie = ImageAsset(name: "flags/IE")
    internal static let il = ImageAsset(name: "flags/IL")
    internal static let im = ImageAsset(name: "flags/IM")
    internal static let `in` = ImageAsset(name: "flags/IN")
    internal static let io = ImageAsset(name: "flags/IO")
    internal static let iq = ImageAsset(name: "flags/IQ")
    internal static let ir = ImageAsset(name: "flags/IR")
    internal static let `is` = ImageAsset(name: "flags/IS")
    internal static let it = ImageAsset(name: "flags/IT")
    internal static let je = ImageAsset(name: "flags/JE")
    internal static let jm = ImageAsset(name: "flags/JM")
    internal static let jo = ImageAsset(name: "flags/JO")
    internal static let jp = ImageAsset(name: "flags/JP")
    internal static let ke = ImageAsset(name: "flags/KE")
    internal static let kg = ImageAsset(name: "flags/KG")
    internal static let kh = ImageAsset(name: "flags/KH")
    internal static let ki = ImageAsset(name: "flags/KI")
    internal static let km = ImageAsset(name: "flags/KM")
    internal static let kn = ImageAsset(name: "flags/KN")
    internal static let kp = ImageAsset(name: "flags/KP")
    internal static let kr = ImageAsset(name: "flags/KR")
    internal static let kw = ImageAsset(name: "flags/KW")
    internal static let ky = ImageAsset(name: "flags/KY")
    internal static let kz = ImageAsset(name: "flags/KZ")
    internal static let la = ImageAsset(name: "flags/LA")
    internal static let lb = ImageAsset(name: "flags/LB")
    internal static let lc = ImageAsset(name: "flags/LC")
    internal static let li = ImageAsset(name: "flags/LI")
    internal static let lk = ImageAsset(name: "flags/LK")
    internal static let lr = ImageAsset(name: "flags/LR")
    internal static let ls = ImageAsset(name: "flags/LS")
    internal static let lt = ImageAsset(name: "flags/LT")
    internal static let lu = ImageAsset(name: "flags/LU")
    internal static let lv = ImageAsset(name: "flags/LV")
    internal static let ly = ImageAsset(name: "flags/LY")
    internal static let ma = ImageAsset(name: "flags/MA")
    internal static let mc = ImageAsset(name: "flags/MC")
    internal static let md = ImageAsset(name: "flags/MD")
    internal static let me = ImageAsset(name: "flags/ME")
    internal static let mf = ImageAsset(name: "flags/MF")
    internal static let mg = ImageAsset(name: "flags/MG")
    internal static let mh = ImageAsset(name: "flags/MH")
    internal static let mk = ImageAsset(name: "flags/MK")
    internal static let ml = ImageAsset(name: "flags/ML")
    internal static let mm = ImageAsset(name: "flags/MM")
    internal static let mn = ImageAsset(name: "flags/MN")
    internal static let mo = ImageAsset(name: "flags/MO")
    internal static let mp = ImageAsset(name: "flags/MP")
    internal static let mq = ImageAsset(name: "flags/MQ")
    internal static let mr = ImageAsset(name: "flags/MR")
    internal static let ms = ImageAsset(name: "flags/MS")
    internal static let mt = ImageAsset(name: "flags/MT")
    internal static let mu = ImageAsset(name: "flags/MU")
    internal static let mv = ImageAsset(name: "flags/MV")
    internal static let mw = ImageAsset(name: "flags/MW")
    internal static let mx = ImageAsset(name: "flags/MX")
    internal static let my = ImageAsset(name: "flags/MY")
    internal static let mz = ImageAsset(name: "flags/MZ")
    internal static let na = ImageAsset(name: "flags/NA")
    internal static let nc = ImageAsset(name: "flags/NC")
    internal static let ne = ImageAsset(name: "flags/NE")
    internal static let nf = ImageAsset(name: "flags/NF")
    internal static let ng = ImageAsset(name: "flags/NG")
    internal static let ni = ImageAsset(name: "flags/NI")
    internal static let nl = ImageAsset(name: "flags/NL")
    internal static let no = ImageAsset(name: "flags/NO")
    internal static let np = ImageAsset(name: "flags/NP")
    internal static let nr = ImageAsset(name: "flags/NR")
    internal static let nu = ImageAsset(name: "flags/NU")
    internal static let nz = ImageAsset(name: "flags/NZ")
    internal static let om = ImageAsset(name: "flags/OM")
    internal static let pa = ImageAsset(name: "flags/PA")
    internal static let pe = ImageAsset(name: "flags/PE")
    internal static let pf = ImageAsset(name: "flags/PF")
    internal static let pg = ImageAsset(name: "flags/PG")
    internal static let ph = ImageAsset(name: "flags/PH")
    internal static let pk = ImageAsset(name: "flags/PK")
    internal static let pl = ImageAsset(name: "flags/PL")
    internal static let pm = ImageAsset(name: "flags/PM")
    internal static let pn = ImageAsset(name: "flags/PN")
    internal static let pr = ImageAsset(name: "flags/PR")
    internal static let ps = ImageAsset(name: "flags/PS")
    internal static let pt = ImageAsset(name: "flags/PT")
    internal static let pw = ImageAsset(name: "flags/PW")
    internal static let py = ImageAsset(name: "flags/PY")
    internal static let qa = ImageAsset(name: "flags/QA")
    internal static let re = ImageAsset(name: "flags/RE")
    internal static let ro = ImageAsset(name: "flags/RO")
    internal static let rs = ImageAsset(name: "flags/RS")
    internal static let ru = ImageAsset(name: "flags/RU")
    internal static let rw = ImageAsset(name: "flags/RW")
    internal static let sa = ImageAsset(name: "flags/SA")
    internal static let sb = ImageAsset(name: "flags/SB")
    internal static let sc = ImageAsset(name: "flags/SC")
    internal static let sd = ImageAsset(name: "flags/SD")
    internal static let se = ImageAsset(name: "flags/SE")
    internal static let sg = ImageAsset(name: "flags/SG")
    internal static let sh = ImageAsset(name: "flags/SH")
    internal static let si = ImageAsset(name: "flags/SI")
    internal static let sj = ImageAsset(name: "flags/SJ")
    internal static let sk = ImageAsset(name: "flags/SK")
    internal static let sl = ImageAsset(name: "flags/SL")
    internal static let sm = ImageAsset(name: "flags/SM")
    internal static let sn = ImageAsset(name: "flags/SN")
    internal static let so = ImageAsset(name: "flags/SO")
    internal static let sr = ImageAsset(name: "flags/SR")
    internal static let ss = ImageAsset(name: "flags/SS")
    internal static let st = ImageAsset(name: "flags/ST")
    internal static let sv = ImageAsset(name: "flags/SV")
    internal static let sx = ImageAsset(name: "flags/SX")
    internal static let sy = ImageAsset(name: "flags/SY")
    internal static let sz = ImageAsset(name: "flags/SZ")
    internal static let tc = ImageAsset(name: "flags/TC")
    internal static let td = ImageAsset(name: "flags/TD")
    internal static let tf = ImageAsset(name: "flags/TF")
    internal static let tg = ImageAsset(name: "flags/TG")
    internal static let th = ImageAsset(name: "flags/TH")
    internal static let tj = ImageAsset(name: "flags/TJ")
    internal static let tk = ImageAsset(name: "flags/TK")
    internal static let tl = ImageAsset(name: "flags/TL")
    internal static let tm = ImageAsset(name: "flags/TM")
    internal static let tn = ImageAsset(name: "flags/TN")
    internal static let to = ImageAsset(name: "flags/TO")
    internal static let tr = ImageAsset(name: "flags/TR")
    internal static let tt = ImageAsset(name: "flags/TT")
    internal static let tv = ImageAsset(name: "flags/TV")
    internal static let tw = ImageAsset(name: "flags/TW")
    internal static let tz = ImageAsset(name: "flags/TZ")
    internal static let ua = ImageAsset(name: "flags/UA")
    internal static let ug = ImageAsset(name: "flags/UG")
    internal static let um = ImageAsset(name: "flags/UM")
    internal static let us = ImageAsset(name: "flags/US")
    internal static let uy = ImageAsset(name: "flags/UY")
    internal static let uz = ImageAsset(name: "flags/UZ")
    internal static let va = ImageAsset(name: "flags/VA")
    internal static let vc = ImageAsset(name: "flags/VC")
    internal static let ve = ImageAsset(name: "flags/VE")
    internal static let vg = ImageAsset(name: "flags/VG")
    internal static let vi = ImageAsset(name: "flags/VI")
    internal static let vn = ImageAsset(name: "flags/VN")
    internal static let vu = ImageAsset(name: "flags/VU")
    internal static let wf = ImageAsset(name: "flags/WF")
    internal static let ws = ImageAsset(name: "flags/WS")
    internal static let ye = ImageAsset(name: "flags/YE")
    internal static let yt = ImageAsset(name: "flags/YT")
    internal static let za = ImageAsset(name: "flags/ZA")
    internal static let zm = ImageAsset(name: "flags/ZM")
    internal static let zw = ImageAsset(name: "flags/ZW")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = Color(asset: self)

  #if os(iOS) || os(tvOS)
  @available(iOS 11.0, tvOS 11.0, *)
  internal func color(compatibleWith traitCollection: UITraitCollection) -> Color {
    let bundle = BundleToken.bundle
    guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init!(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if os(iOS) || os(tvOS)
  @available(iOS 8.0, tvOS 9.0, *)
  internal func image(compatibleWith traitCollection: UITraitCollection) -> Image {
    let bundle = BundleToken.bundle
    guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
  #endif
}

internal extension ImageAsset.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init!(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
