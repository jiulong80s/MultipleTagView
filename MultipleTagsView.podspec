
Pod::Spec.new do |s|
  s.name         = "MultipleTagsView"
  s.version      = "1.0.0"
  s.summary      = "Multi-row columns of multiple button views.."
  s.description  = <<-DESC
  1. Specify a fixed number of columns to be allocated according to the view width (固定显示列数，tag的宽度将根据MultipleTagsView的宽度均分)
  2. Do not specify the number of columns, and the length of the title of the button will automatically match the width.(不指定列数，tag的宽度根据它的title自适配)
                 DESC
  s.homepage     = "https://github.com/jiulong80s/MultipleTagView"
  s.screenshots  = "http://chuantu.biz/t5/149/1500972349x1001167534.png"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }  
  s.author       = { "jiulong.zhou" => "zhoujiulong86@163.com" }
  s.platform     = :ios
  s.requires_arc = true
  s.source       = { :git => "https://github.com/jiulong80s/MultipleTagView.git", :tag => s.version }
  s.source_files = "lib/MultipleTagsView/*{h,m}"
end
