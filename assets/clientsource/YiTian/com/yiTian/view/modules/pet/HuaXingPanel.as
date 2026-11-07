package com.yiTian.view.modules.pet
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.PetCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.MassLoader;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFormat;
   
   public class HuaXingPanel extends Panel123
   {
      
      public static var spePetModelIdVec:Vector.<int> = new <int>[20701,20702,20703,20704];
      
      private var instance4:MyTextField;
      
      private var HuaXingbtn:Button;
      
      private var _petVO:PetVO;
      
      private var qiXueTxt:MyTextField;
      
      private var nameTxt:MyTextField;
      
      private var dengJiTxt:MyTextField;
      
      private var ziZhiTxt:MyTextField;
      
      private var zhanLiTxt:MyTextField;
      
      private var gongJiTxt:MyTextField;
      
      private var fangYuTxt:MyTextField;
      
      private var mingZhongTxt:MyTextField;
      
      private var shanBiTxt:MyTextField;
      
      private var baoJiTxt:MyTextField;
      
      private var suDuTxt:MyTextField;
      
      private var tf:TextFormat;
      
      private var qiXueMask:Shape;
      
      private var jiNengGridVec:Vector.<View_Grid>;
      
      private var viewVec:Vector.<Sprite>;
      
      private var jiNengBtnVec:Vector.<Button>;
      
      public var btnHuaXing:Button;
      
      public var btnJingxXiu:Button;
      
      private var _PetVO:PetVO;
      
      private var imgBM:Bitmap;
      
      private var imgBM2:Bitmap;
      
      private const INTERVALFRAM:int = 5;
      
      private var imgList:Vector.<BitmapData>;
      
      private var imgList2:Vector.<BitmapData>;
      
      private var playIndex:int = 0;
      
      private var playIndex2:int = 0;
      
      private var spImg:Sprite;
      
      private var spImg2:Sprite;
      
      private var _info:Object;
      
      private var _info2:Object;
      
      private var qiXueBG:Bitmap;
      
      private var spePetSysIdVec:Vector.<Number> = new <Number>[45209,45210,45211,45212];
      
      public function HuaXingPanel()
      {
         super();
         regResource("lang/ch/Pet_Imgs.swf","Pet_Imgsdm");
      }
      
      override protected function initStaticView() : void
      {
         var back:DisplayObject = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":446,
            "height":382
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":27,
            "y":40,
            "width":393,
            "height":331
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":37,
            "y":50,
            "width":373,
            "height":166
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":37,
            "y":224,
            "width":373,
            "height":105
         },Global.Img_Cdm);
         move = new Rectangle(0,0,back.width,35);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":412,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
      }
      
      override protected function initUI2() : void
      {
         ComponentUtil.getTextField(LangConfig.getWord("60398",6),this,{
            "x":50,
            "y":228,
            "color":16773818,
            "size":14,
            "leading":5
         });
         var HuaXingtf:MyTextField = ComponentUtil.getTextField("",this,{
            "x":50,
            "y":248,
            "color":16773818,
            "size":12,
            "leading":5
         });
         var HuaXingtf2:MyTextField = ComponentUtil.getTextField("",this,{
            "x":50,
            "y":268,
            "color":16773818,
            "size":12,
            "leading":5
         });
         ComponentUtil.getTextField("3." + LangConfig.getWord("60400",6),this,{
            "x":50,
            "y":288,
            "color":16773818,
            "size":12,
            "leading":5
         });
         ComponentUtil.getTextField("4." + LangConfig.getWord("60401",6),this,{
            "x":50,
            "y":308,
            "color":16773818,
            "size":12,
            "leading":5
         });
         HuaXingtf.htmlText = LangConfig.getWord("60399",6);
         HuaXingtf2.htmlText = LangConfig.getWord("60445",6);
         this.HuaXingbtn = ComponentUtil.getButton(LangConfig.getWord("60436",6),"Button_Two64",this,{
            "x":191.5,
            "y":337,
            "textColor":16773818
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Txt_HuaXing",this,{
            "x":143,
            "y":5
         },Global.Pet_Imgsdm);
         ComponentUtil.getBitmap("ZHDiKuang",this,{
            "x":50,
            "y":62
         },Global.Pet_Imgsdm);
         ComponentUtil.getBitmap("ZHJianTou",this,{
            "x":179,
            "y":73
         },Global.Pet_Imgsdm);
         ComponentUtil.getBitmap("ZHDiKuang",this,{
            "x":269,
            "y":62
         },Global.Pet_Imgsdm);
         this.HuaXingbtn.addEventListener(MouseEvent.CLICK,this.HuaXingClick);
         this.resetPosition();
      }
      
      private function HuaXingClick(e:MouseEvent) : void
      {
         if(UIManager.petPanel.petVO.level >= 90)
         {
            if(UIManager.petPanel.petVO.ziZhi > 90)
            {
               if(CommandManager.get_bag_count(46412,2) >= 30)
               {
                  if(CommandManager.get_bag_count(46801,2) >= 20)
                  {
                     PetCGMessage.CG_BT_HUAXING();
                  }
                  else
                  {
                     UIManager.centerBroadcast.addMsg(LangConfig.getWord("60444",6));
                  }
               }
               else
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("60437",6));
               }
            }
            else
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("60438",6));
            }
         }
         else
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("60439",6));
         }
      }
      
      public function remove() : void
      {
         this.HuaXingbtn.removeEventListener(MouseEvent.CLICK,this.HuaXingClick);
         UIManager.huaxing.visible = false;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
      
      private function onComplete(info:Object) : void
      {
         var c:Class = null;
         var d:BitmapData = null;
         if(!this.spImg)
         {
            this.spImg = new Sprite();
            addChild(this.spImg);
            this.imgBM = new Bitmap();
            this.spImg.addChild(this.imgBM);
            this.spImg.x = 110;
            this.spImg.y = 170;
         }
         this._info = info;
         this._info.content.init();
         this.imgList = new Vector.<BitmapData>(this.INTERVALFRAM * this._info.content.actionFrame,true);
         var i:int = 0;
         var j:int = 0;
         while(i < this.INTERVALFRAM * this._info.content.actionFrame)
         {
            if(i % this.INTERVALFRAM == 0)
            {
               c = info.applicationDomain.getDefinition("_" + (4 * this._info.content.actionFrame + j++)) as Class;
               d = new c();
               this.imgList[i] = d;
            }
            i++;
         }
         GameScene.instance.addFrameCallBack(this.playImg);
      }
      
      private function onComplete2(info:Object) : void
      {
         var c:Class = null;
         var d:BitmapData = null;
         if(!this.spImg2)
         {
            this.spImg2 = new Sprite();
            addChild(this.spImg2);
            this.imgBM2 = new Bitmap();
            this.spImg2.addChild(this.imgBM2);
            this.spImg2.x = 330;
            this.spImg2.y = 170;
         }
         this._info2 = info;
         this._info2.content.init();
         this.imgList2 = new Vector.<BitmapData>(this.INTERVALFRAM * this._info2.content.actionFrame,true);
         var i:int = 0;
         var j:int = 0;
         while(i < this.INTERVALFRAM * this._info2.content.actionFrame)
         {
            if(i % this.INTERVALFRAM == 0)
            {
               c = info.applicationDomain.getDefinition("_" + (4 * this._info2.content.actionFrame + j++)) as Class;
               d = new c();
               this.imgList2[i] = d;
            }
            i++;
         }
         GameScene.instance.addFrameCallBack(this.playImg2);
      }
      
      private function playImg(interval:int) : void
      {
         if(!visible)
         {
            GameScene.instance.removeFrameCallBack(this.playImg);
         }
         if(this.playIndex < this.imgList.length)
         {
            if(this.imgList[this.playIndex] != null)
            {
               this.imgBM.x = this._info.content.rect[this._info.content.actionFrame * 4 + this.playIndex / this.INTERVALFRAM][0];
               this.imgBM.y = this._info.content.rect[this._info.content.actionFrame * 4 + this.playIndex / this.INTERVALFRAM][1];
               this.imgBM.bitmapData = this.imgList[this.playIndex];
            }
            ++this.playIndex;
         }
         else
         {
            this.playIndex = 0;
         }
      }
      
      private function playImg2(interval:int) : void
      {
         if(!visible)
         {
            GameScene.instance.removeFrameCallBack(this.playImg2);
         }
         if(this.playIndex2 < this.imgList2.length)
         {
            if(this.imgList2[this.playIndex2] != null)
            {
               this.imgBM2.x = this._info2.content.rect[this._info2.content.actionFrame * 4 + this.playIndex2 / this.INTERVALFRAM][0];
               this.imgBM2.y = this._info2.content.rect[this._info2.content.actionFrame * 4 + this.playIndex2 / this.INTERVALFRAM][1];
               this.imgBM2.bitmapData = this.imgList2[this.playIndex2];
            }
            ++this.playIndex2;
         }
         else
         {
            this.playIndex2 = 0;
         }
      }
      
      private function loadImg() : void
      {
         if(spePetModelIdVec.indexOf(UIManager.petPanel.petVO.img) >= 0)
         {
            MassLoader.add("modelRes/role/body/run/" + UIManager.petPanel.petVO.img + ".swf",this.onComplete,null,MassLoader.LEVEL2,null,Enum_resType.MODEL_URL);
            MassLoader.add("modelRes/role/body/run/" + UIManager.petPanel.petVO.img + ".swf",this.onComplete2,null,MassLoader.LEVEL2,null,Enum_resType.MODEL_URL);
         }
         else
         {
            MassLoader.add("modelRes/role/body/run/" + UIManager.petPanel.petVO.img + ".swf",this.onComplete,null,MassLoader.LEVEL2,null,Enum_resType.MODEL_URL);
            MassLoader.add("modelRes/role/body/run/" + (UIManager.petPanel.petVO.img - 100).toString() + ".swf",this.onComplete2,null,MassLoader.LEVEL2,null,Enum_resType.MODEL_URL);
         }
      }
      
      private function isSpecialPet() : Boolean
      {
         var i:int = 0;
         i = 0;
         while(i < this.spePetSysIdVec.length)
         {
            if(UIManager.petPanel.petVO.img == spePetModelIdVec[i])
            {
               return true;
            }
            i++;
         }
         return false;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            this.loadImg();
         }
      }
   }
}

