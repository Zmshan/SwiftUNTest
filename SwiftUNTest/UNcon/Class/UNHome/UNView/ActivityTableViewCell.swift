//
//  ActivityTableViewCell.swift
//  SwiftUNTest
//
//  Created by open-roc on 2020/11/27.
//

import UIKit
import HandyJSON
import Kingfisher
class ActivityTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColorFromRGB(rgbValue: 0xF8F9FB)
        self.loadUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func objectFun(jsonData:Any){
        if let item = JSONDeserializer<COMModel>.deserializeFrom(json: (jsonData as! String)) {
            let mainImg:NSString =  item.mainImg
            var url =  HOST
            url.append(mainImg as String)
            let pUrl = URL(string: url as String)!
            iconImage.kf.setImage(with: ImageResource(downloadURL: pUrl ), placeholder: UIImage(named: url as String), options: nil, progressBlock: nil, completionHandler: { (image, error, cacheType, imageURL) in
                
            })
            title.text = item.activityName as String
            subTitle.text = item.description as String
            var beginTime:String = item.activityBeginTime as String
            let endTime:String = item.activityBeginTime as String
            beginTime.append("至"+endTime)
            subToTitle.text = beginTime
        }

         
    }
    @objc func loadUI(){
        
        self.contentView.addSubview(contView);
        contView.addSubview(iconImage);
        contView.addSubview(title);
        contView.addSubview(subTitle);
        contView.addSubview(subToTitle);
        
        contView.snp_makeConstraints { (make) in
//            make.edges.equalTo(self.contentView);
            make.top.equalTo(self.contentView).offset(0);
            make.left.equalTo(self.contentView).offset(16);
            make.right.equalTo(self.contentView).offset(-16);
            make.bottom.equalTo(self.contentView).offset(-16);
//            make.leftMargin.equalTo(32)
//            make.rightMargin.equalTo(32)
//            make.bottomMargin.equalTo(32);
        }
        iconImage.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(contView)
            make.height.equalTo(160)
        }
        title.snp_makeConstraints { (make) in
            make.top.equalTo(iconImage.snp_bottom).offset(16)
            make.left.right.equalTo(contView)
        }
        subTitle.snp_makeConstraints { (make) in
            make.top.equalTo(title.snp_bottom).offset(16)
            make.left.right.equalTo(contView)
        }
        subToTitle.snp_makeConstraints { (make) in
            make.top.equalTo(subTitle.snp_bottom).offset(16)
            make.left.right.equalTo(contView)
            make.bottom.equalTo(contView).offset(-2)
        }
        
    }
    lazy  var contView:UIView = {
            var  view  =  UIView.init()
            view.backgroundColor = UIColor .blue;
            return view

    }()
    lazy  var iconImage:UIImageView = {
            var  view  =  UIImageView.init()
            view.backgroundColor = UIColor .darkGray;

            return view

    }()
    lazy  var title:UILabel = {
            var  view  =  UILabel.init()
            view.backgroundColor = UIColor .green;

            return view

    }()
    lazy  var subTitle:UILabel = {
            var  view  =  UILabel.init()
            view.backgroundColor = UIColor .green;

            return view

    }()
    lazy  var subToTitle:UILabel = {
            var  view  =  UILabel.init()
            view.backgroundColor = UIColor .green;
            return view

    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
