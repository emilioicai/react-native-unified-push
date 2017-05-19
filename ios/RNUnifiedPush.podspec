
Pod::Spec.new do |s|
  s.name         = "RNUnifiedPush"
  s.version      = "1.0.0"
  s.summary      = "RNUnifiedPush"
  s.description  = <<-DESC
                  RNUnifiedPush
                   DESC
  s.homepage     = ""
  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "author" => "emrodrig@redhat.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/author/RNUnifiedPush.git", :tag => "master" }
  s.source_files  = "RNUnifiedPush/**/*.{h,m}"
  s.requires_arc = true


  s.dependency "React"
  #s.dependency "others"

end

  