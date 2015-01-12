Pod::Spec.new do |s|
  s.name      = "IDPKit"
  s.version   = "0.1.0"
  s.summary   = "Reusable IDAP Group classes and categories"
  s.homepage  = "https://github.com/idapgroup/IDPKit"
  s.license   = { :type => "New BSD", :file => "LICENSE" }
  s.author    = { "IDAP Group" => "admin@idapgroup.com" }
  s.source    = { :git => "https://github.com/idapgroup/IDPKit.git", 
                  :tag => s.version.to_s }

  # Platform setup
  s.requires_arc          = false  
  s.ios.deployment_target = '7.0'
  s.osx.deployment_target = '10.8'
  
  # Set default frameworks
  s.default_subspec       = 'Core'
  
  # Preserve the layout of headers in the Module directory
  s.header_mappings_dir   = 'Module'
  
  # Subspecs
  s.subspec 'Core' do |cs|
    cs.dependency     'IDPKit/FoundationKit'
    cs.dependency     'IDPKit/ActiveRecordKit'    
    cs.dependency     'IDPKit/CoreGraphicsKit'
    cs.dependency     'IDPKit/QuartzCoreKit'
    cs.dependency     'IDPKit/SystemConfigKit'    
    cs.ios.dependency 'IDPKit/TouchKit'
    cs.osx.dependency 'IDPKit/DeskKit'
  end
  
  s.subspec 'FoundationKit' do |fks|
    fks.source_files   = 'Module/FoundationKit/**/*.{h,m,c,cpp}'
    fks.frameworks     = 'Foundation'
  end
  
  s.subspec 'ActiveRecordKit' do |ars|
    ars.source_files   = 'Module/ActiveRecordKit/**/*.{h,m,c,cpp}'
    ars.frameworks     = 'CoreData'
    ars.dependency       'IDPKit/FoundationKit'
  end    
  
  s.subspec 'CoreGraphicsKit' do |cgs|
    cgs.source_files   = 'Module/CoreGraphicsKit/**/*.{h,m,c,cpp}'
    cgs.frameworks     = 'CoreGraphics'
  end
  
  s.subspec 'QuartzCoreKit' do |qcs|
    qcs.source_files   = 'Module/QuartzCoreKit/**/*.{h,m,c,cpp}'
    qcs.frameworks     = 'QuartzCore'
    qcs.dependency       'IDPKit/CoreGraphicsKit'
  end
  
  s.subspec 'SystemConfigKit' do |scs|
    scs.source_files   = 'Module/SystemConfigKit/**/*.{h,m,c,cpp}'
    scs.frameworks     = 'SystemConfiguration'
    scs.dependency       'IDPKit/FoundationKit'
  end
  
  s.subspec 'TouchKit' do |tks|
    tks.source_files   = 'Module/TouchKit/**/*.{h,m,c,cpp}'
    tks.platform       = :ios, "7.0"
    tks.frameworks     = 'UIKit'
    tks.dependency       'IDPKit/FoundationKit'
    tks.dependency       'IDPKit/CoreGraphicsKit'
  end
  
  s.subspec 'DeskKit' do |dks|
    dks.source_files   = 'Module/DeskKit/**/*.{h,m,c,cpp}'
    dks.platform       = :osx, "10.8"    
    dks.frameworks     = 'AppKit'
    dks.dependency       'IDPKit/FoundationKit'
    dks.dependency       'IDPKit/CoreGraphicsKit'
  end
end
