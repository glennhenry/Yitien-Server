package com.yiTian.view.modules.huaShanLunJian.viewer
{
   import com.ui.controls.MaskProgressBar;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Const_strImg;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.utils.Bitmap2;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.ViewerCreator;
   import com.yiTian.view.modules.huaShanLunJian.util.Enum_HuaShan;
   import com.yiTian.view.modules.huaShanLunJian.util.HuaShanUtil;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.text.TextFieldAutoSize;
   
   public class Child_ZhuFuInfo extends Sprite
   {
      
      private var bm_roleHead:Bitmap2;
      
      private var tf_roleName:MyTextField;
      
      private var shp_mask:Shape;
      
      private var tf_star1:MyTextField;
      
      private var tf_abb1:MyTextField;
      
      private var tf_star2:MyTextField;
      
      private var tf_abb2:MyTextField;
      
      private var pb:MaskProgressBar;
      
      private var tf_blessValue:MyTextField;
      
      private var bSelected:Boolean = false;
      
      private var _data:Array;
      
      public var oldLv:int = 1;
      
      public var oldStar:int = 0;
      
      public var oldExp:Number = 0;
      
      public function Child_ZhuFuInfo()
      {
         super();
         this.init1();
      }
      
      public function init1() : void
      {
         ComponentUtil.getBitmap("Back_Card",this,{
            "x":0,
            "y":0
         },Global.kuafuzhan_Imgsdm);
         ComponentUtil.getBitmap("Winner_Back",this,{
            "x":56,
            "y":8
         },Global.kuafuzhan_Imgsdm);
         var creatorObj:Array = [[Bitmap2,{
            "y":15,
            "name":"bm"
         }],[MyTextField,{
            "text":"",
            "x":95,
            "y":87,
            "name":"rolename",
            "size":16,
            "bold":true,
            "color":16729156,
            "autoSize":TextFieldAutoSize.CENTER
         }],[MyTextField,{
            "x":95,
            "y":113,
            "name":"star1",
            "color":16776960,
            "autoSize":TextFieldAutoSize.CENTER
         }],[MyTextField,{
            "x":95,
            "y":136,
            "name":"abb1",
            "color":65280,
            "autoSize":TextFieldAutoSize.CENTER
         }],[MyTextField,{
            "x":95,
            "y":170,
            "name":"star2",
            "color":16776960,
            "autoSize":TextFieldAutoSize.CENTER
         }],[MyTextField,{
            "x":95,
            "y":190,
            "name":"abb2",
            "color":65280,
            "autoSize":TextFieldAutoSize.CENTER
         }]];
         ViewerCreator.createViewer(creatorObj,this);
         this.bm_roleHead = getChildByName("bm") as Bitmap2;
         this.tf_roleName = getChildByName("rolename") as MyTextField;
         this.tf_star1 = getChildByName("star1") as MyTextField;
         this.tf_abb1 = getChildByName("abb1") as MyTextField;
         this.tf_star2 = getChildByName("star2") as MyTextField;
         this.tf_abb2 = getChildByName("abb2") as MyTextField;
         var pbBG:Bitmap = ComponentUtil.getBitmap("ZFProgress_Back",null,{"x":-8},Global.kuafuzhan_Imgsdm);
         var pbBar:Bitmap = ComponentUtil.getBitmap("ZFProgress",null,{"y":6},Global.kuafuzhan_Imgsdm);
         this.pb = new MaskProgressBar();
         this.pb.bar = pbBar;
         this.pb.bg = pbBG;
         ComponentUtil.setPropertie(this.pb,{
            "x":14,
            "y":213,
            "realWidth":168
         });
         this.pb.init();
         addChild(this.pb);
         this.tf_blessValue = ComponentUtil.getTextField("",this.pb,{
            "x":this.pb.realWidth / 2,
            "autoSize":TextFieldAutoSize.CENTER
         });
         this.shp_mask = new Shape();
         this.shp_mask.graphics.beginFill(16777215);
         this.shp_mask.graphics.drawCircle(0,32.5,32.5);
         this.shp_mask.x = 97;
         this.shp_mask.y = 15;
         this.shp_mask.graphics.endFill();
         addChild(this.shp_mask);
         this.bm_roleHead.mask = this.shp_mask;
      }
      
      public function set bmScaleX(number:Number) : void
      {
         if(number == 1)
         {
            this.bm_roleHead.x = 32.5 + 163 - 128;
         }
         else
         {
            this.bm_roleHead.x = -32.5 + 163;
         }
         this.bm_roleHead.scaleX = number;
      }
      
      public function play(startLv:int, startStar:int, startExp:int, disLV:int, disStar:int, disExp:int, costTime:int = 1500) : void
      {
         this.oldLv = disLV;
         this.oldStar = disStar;
         this.oldExp = disExp;
         var starInfo:Array = HuaShanUtil.getBlessAbbArr(startLv,startStar);
         var startPercent:Number = starInfo[2] == 0 ? 1 : startExp / starInfo[2];
         var disMaxExp:Number = Number(HuaShanUtil.getBlessAbbArr(disLV,disStar)[2]);
         var disPercent:Number = disMaxExp == 0 ? 1 : disExp / disMaxExp;
         var start:Number = startLv * 11 + startStar + startPercent;
         var end:Number = disLV * 11 + disStar + disPercent;
         Tween.to(this,costTime,{"persent":[start,end]},null,null,Tween.EASYINOUT);
      }
      
      public function setInfo(lv:int, star:int, perc:Number) : void
      {
         this.tf_star1.htmlText = Util.rep(LangConfig.getWord("29350",2),lv,star);
         var mxExp:Number = Number(HuaShanUtil.getBlessAbbArr(lv,star)[2]);
         this.tf_blessValue.text = Math.round(mxExp * perc) + "/" + mxExp;
         this.pb.persent = perc;
      }
      
      public function set persent(num:Number) : void
      {
         var curStar:int = 0;
         var p:Number = NaN;
         var curLv:int = num / 11 << 0;
         if(curLv > 9)
         {
            curLv = 9;
            curStar = 10;
            p = 1;
         }
         else
         {
            curStar = num % 11;
            p = num > 1 ? num - int(num) : num;
         }
         this.setInfo(curLv,curStar,p);
      }
      
      public function update2(roleID:Number, blessLV:int, blessStar:int, blessExp:int) : void
      {
         if(!this._data)
         {
            return;
         }
         if(this._data[Enum_HuaShan.CONT_ID] != roleID)
         {
            return;
         }
         this._data[Enum_HuaShan.CONT_BLESSLV] = blessLV;
         this._data[Enum_HuaShan.CONT_BLESSSTAR] = blessStar;
         this._data[Enum_HuaShan.CONT_BLESSEXP] = blessExp;
         var total:int = blessLV * 11 + blessStar + 1;
         var nxtLv:int = int(total / 11);
         var nxtStar:int = total % 11;
         this.tf_abb1.text = HuaShanUtil.getBlessAbbStr(blessLV,blessStar);
         if(nxtLv < 10)
         {
            this.tf_star2.text = Util.rep(LangConfig.getWord("29351",2) + LangConfig.getWord("29350",2),nxtLv,nxtStar);
         }
         else
         {
            this.tf_star2.text = LangConfig.getWord("29352",2);
         }
         this.tf_abb2.text = HuaShanUtil.getBlessAbbStr(nxtLv,nxtStar);
         this.play(this.oldLv,this.oldStar,this.oldExp,blessLV,blessStar,blessExp,2000);
      }
      
      public function set selected(b:Boolean) : void
      {
         this.bSelected = b;
      }
      
      public function get selected() : Boolean
      {
         return this.bSelected;
      }
      
      public function update(obj:Object) : void
      {
         this._data = obj as Array;
         var roleID:int = int(this._data[Enum_HuaShan.CONT_ID]);
         var roleName:String = this._data[Enum_HuaShan.CONT_ROLENAME];
         var lv:int = int(this._data[Enum_HuaShan.CONT_ROLELV]);
         var strength:int = int(this._data[Enum_HuaShan.CONT_ROLESTRENGTH]);
         var roleSex:int = int(this._data[Enum_HuaShan.CONT_ROLESEX]);
         var roleJob:int = int(this._data[Enum_HuaShan.CONT_ROLEJOB]);
         var blessLV:int = int(this._data[Enum_HuaShan.CONT_BLESSLV]);
         var blessStar:int = int(this._data[Enum_HuaShan.CONT_BLESSSTAR]);
         var blessExp:int = int(this._data[Enum_HuaShan.CONT_BLESSEXP]);
         var serv:String = this._data[Enum_HuaShan.CONT_SERVNAME];
         var str_roleHeadUrl:String = Const_strImg.getPlayerHead(roleJob,roleSex);
         this.tf_roleName.text = Model_heFu.repNameByHero(roleName + ".S" + serv);
         this.tf_abb1.text = HuaShanUtil.getBlessAbbStr(blessLV,blessStar);
         this.tf_star1.text = LangConfig.getWord("29350",2,blessLV,blessStar);
         var total:int = blessLV * 11 + blessStar + 1;
         var nxtLv:int = int(total / 11);
         var nxtStar:int = total % 11;
         if(nxtLv < 10)
         {
            this.tf_star2.text = Util.rep(LangConfig.getWord("29351",2) + LangConfig.getWord("29350",2),nxtLv,nxtStar);
         }
         else
         {
            this.tf_star2.text = LangConfig.getWord("29352",2);
         }
         var maxExp:int = int(HuaShanUtil.getBlessAbbArr(blessLV,blessStar)[2]);
         this.tf_abb2.text = HuaShanUtil.getBlessAbbStr(nxtLv,nxtStar);
         this.tf_blessValue.text = blessExp + "/" + maxExp;
         this.oldLv = blessLV;
         this.oldStar = blessStar;
         this.oldExp = blessExp;
         this.bm_roleHead.load(str_roleHeadUrl,1);
         Tween.stop(this);
         if(blessLV != 0)
         {
            Tween.to(this.pb,1500,{"persent":[0,blessExp / maxExp]});
         }
         else
         {
            Tween.to(this.pb,1500,{"persent":[0,1]});
         }
      }
   }
}

