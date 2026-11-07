package com.yiTian.view.modules.activity
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.ui.controls.TabButton;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.GengXinCGMessage;
   import com.yiTian.utils.MassLoader;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Enum_explor;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.guaji.BitmapBtn;
   import com.yiTian.view.modules.marriage.Model_Marriage;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Shape;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormatAlign;
   
   public class View_ActivityMainPanel extends Panel
   {
      
      private static var tip:BitmapBtn;
      
      private static const bitmapDir:String = "resource/image/gengXin/gengxinBtn.png";
      
      public static var isGengXinPan:Boolean = false;
      
      private var tabbtn_mrrw:TabButton;
      
      private var tabBtn_mrhd:TabButton;
      
      private var tabBtn_gxgg:TabButton;
      
      private var back:DisplayObject;
      
      public var mrrw:Child_ActivityDaily;
      
      public var mrhd:Child_ActDailyItem;
      
      public var gxgg:Child_GengXinGongGao;
      
      private var tf_descript:MyTextField;
      
      private var tf_time:MyTextField;
      
      private var _gridVec:Vector.<View_Grid>;
      
      private var _labelArr:Array = [[21201,45,76,16764206],[21202,138,76,16764206],[21203,231,76,16764206],[21204,324,76,16764206],[21205,465,76,16764206],[21206,465,186,16764206],[21207,465,276,16764206]];
      
      private var _laberArr2:Array = [[21211],[21212],[21213],[21214],[21215],[21216],[21217]];
      
      private var title:ScaleBitmap;
      
      private var titleRight1:ScaleBitmap;
      
      private var titleRight2:ScaleBitmap;
      
      private var titleRight3:ScaleBitmap;
      
      private var backRight:ScaleBitmap;
      
      private var backLeft:ScaleBitmap;
      
      private var GXBack2:ScaleBitmap;
      
      private var GXMM:Bitmap;
      
      private var GXBCBB:Bitmap;
      
      private var GXBack4:ScaleBitmap;
      
      private var GXChuanWen:ScaleBitmap;
      
      private var GXGG:ScaleBitmap;
      
      private var queDingBtn:Button;
      
      private var b:Boolean = false;
      
      private var tf_vec:Vector.<MyTextField>;
      
      private var isFirstOpen:Boolean = true;
      
      private var isLoad:Boolean = false;
      
      private var refreshFlag:Boolean;
      
      private var isRight:Boolean = true;
      
      public function View_ActivityMainPanel()
      {
         super();
      }
      
      public static function GC_SNATCH_LQROOM() : void
      {
         if(GameUnitManager.hero.level <= 50)
         {
            return;
         }
         tip = new BitmapBtn();
         tip.init();
         tip.setBgDir(bitmapDir);
         tip.clickCallBack = replayClickCB;
         UIManager.tipBtnContainer.addItem(tip);
      }
      
      private static function replayClickCB(e:MouseEvent) : void
      {
         GengXinCGMessage.CG_GENGXINGONGGAO();
         UIManager.amPanel.showPage(2);
         UIManager.tipBtnContainer.removeItem(tip);
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.back.width) / 2;
         y = (Global.stage.stageHeight - this.back.height) / 2;
      }
      
      override protected function initStaticView() : void
      {
         this.back = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":618,
            "height":445
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":66,
            "width":570,
            "height":368
         },Global.Img_Cdm);
         this.backLeft = ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":31,
            "y":74,
            "width":360,
            "height":350
         },Global.Img_Cdm);
         this.backRight = ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":398,
            "y":74,
            "width":189,
            "height":350
         },Global.Img_Cdm);
         this.title = ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":33,
            "y":76,
            "width":356,
            "height":20
         },Global.Img_Cdm);
         this.titleRight1 = ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":400,
            "y":76,
            "width":185,
            "height":20
         },Global.Img_Cdm);
         this.titleRight2 = ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":400,
            "y":186,
            "width":185,
            "height":20
         },Global.Img_Cdm);
         this.titleRight3 = ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":400,
            "y":276,
            "width":185,
            "height":20
         },Global.Img_Cdm);
         this.tabbtn_mrrw = ComponentUtil.getTabButton(LangConfig.getWord("21221",2),"TabButton_Four",this,{
            "x":36,
            "y":45,
            "textColor":16773818,
            "chooseColor":16773818
         },Global.Img_Cdm);
         this.tabBtn_mrhd = ComponentUtil.getTabButton(LangConfig.getWord("21222",2),"TabButton_Four",this,{
            "x":112,
            "y":45,
            "textColor":16773818,
            "chooseColor":16773818
         },Global.Img_Cdm);
         this.tabBtn_gxgg = ComponentUtil.getTabButton("更新公告","TabButton_Four",this,{
            "x":188,
            "y":45,
            "textColor":16773818,
            "chooseColor":16773818
         },Global.Img_Cdm);
         move = new Rectangle(0,0,this.back.width,35);
         this.tf_descript = ComponentUtil.getTextField("",this,{
            "x":406,
            "y":106,
            "realWidth":180,
            "wordWrap":true,
            "color":11515029
         });
         this.tf_descript.mouseEnabled = true;
         this.tf_descript.autoSize = TextFieldAutoSize.CENTER;
         this.tf_time = ComponentUtil.getTextField("1",this,{
            "x":406,
            "y":216,
            "realWidth":178,
            "wordWrap":true,
            "color":11523767
         });
         this.tf_time.autoSize = TextFieldAutoSize.CENTER;
         this.mrrw = new Child_ActivityDaily();
         this.mrrw.init();
         this.mrrw.x = 37;
         this.mrrw.y = 102;
         addChild(this.mrrw);
         this.mrhd = new Child_ActDailyItem();
         this.mrhd.init();
         this.mrhd.x = 37;
         this.mrhd.y = 102;
         addChild(this.mrhd);
         this.gxgg = new Child_GengXinGongGao();
         this.gxgg.x = 37;
         this.gxgg.y = 80;
         addChild(this.gxgg);
         this.createLabel();
         this.createGrid();
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":580,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTER_SCENE,this.enterSceneHd);
      }
      
      private function enterSceneHd(sID:int) : void
      {
         if(sID == 12304)
         {
            UIManager.questTraceView.visible = false;
            UIManager.newMainBtnContainer.visible = false;
            UIManager.special_btn.visible = false;
            this.b = true;
            Model_Marriage.updateViewer();
         }
         else if(this.b)
         {
            UIManager.questTraceView.visible = true;
            UIManager.newMainBtnContainer.visible = true;
            UIManager.special_btn.visible = true;
            UIManager.questTraceView.resetPosition();
            Model_Marriage.updateViewer2();
         }
      }
      
      private function descpriptClickHd(evt:TextEvent) : void
      {
         var id:int = int(evt.text);
         if(id == 20002)
         {
            UIManager.fishIntro.visible = !UIManager.fishIntro.visible;
         }
         else if(id == 20003)
         {
            UIManager.kunlun_jieShao.visible = !UIManager.kunlun_jieShao.visible;
         }
         else if(id == 20004)
         {
            UIManager.bbIntroduce.visible = !UIManager.bbIntroduce.visible;
         }
         else if(id == 20005)
         {
            if(!UIManager.wulin_intro.visible)
            {
               UIManager.wulin_intro.setTile(2);
            }
            UIManager.wulin_intro.visible = !UIManager.wulin_intro.visible;
         }
      }
      
      private function createLabel() : void
      {
         var tf:MyTextField = null;
         this.tf_vec = new Vector.<MyTextField>();
         var i:int = 0;
         while(i < this._labelArr.length)
         {
            tf = ComponentUtil.getTextField("",this,{
               "x":this._labelArr[i][1],
               "y":this._labelArr[i][2],
               "color":this._labelArr[i][3]
            });
            this.tf_vec.push(tf);
            i += 1;
         }
      }
      
      private function createGrid() : void
      {
         var _y:Number = NaN;
         var grid:View_Grid = null;
         var row:int = 0;
         var col:int = 0;
         var i:int = 0;
         this._gridVec = new Vector.<View_Grid>();
         _y = 311;
         i = 0;
         while(i < 6)
         {
            grid = new View_Grid();
            grid.type = Enum_type_grid.NO_DRAG;
            grid.set_bmp_bg();
            grid.set_bmp_over(true,null);
            row = i % 3;
            col = int(i / 3);
            grid.x = 414 + 61 * row;
            grid.y = _y + 45 * col;
            this._gridVec.push(grid);
            addChild(grid);
            i += 1;
         }
      }
      
      private function gridVisble() : void
      {
         var i:int = 0;
         while(i < 6)
         {
            if(!this.isRight)
            {
               this._gridVec[i].visible = false;
            }
            else
            {
               this._gridVec[i].visible = true;
            }
            i++;
         }
      }
      
      public function reset() : void
      {
         this.mrrwClickHd();
      }
      
      override public function set visible(value:Boolean) : void
      {
         var tThis:DisplayObjectContainer = null;
         if(value)
         {
            if(!this.refreshFlag && GameUnitManager.hero.level > 0)
            {
               this.mrhd.lvHd(GameUnitManager.hero.level);
               this.refreshFlag = true;
            }
            if(this.isFirstOpen)
            {
               bind_target = Enum_explor.bind(Enum_explor.BTN_HUODONG);
               this.isFirstOpen = false;
               Utils.loadTitle("lang/ch/Award_Imgs.swf","AwardInf",new Bitmap(),{
                  "x":228,
                  "y":30 - 25
               },this);
               MassLoader.add("lang/ch/GXGG.swf",function(info:Object):void
               {
                  var masks:Shape;
                  Global.GXGGdm = info.applicationDomain;
                  GXMM = ComponentUtil.getBitmap("BG_MM2",tThis,{
                     "x":552,
                     "y":0
                  },Global.GXGGdm);
                  masks = ComponentUtil.getShape(295,476);
                  masks.x = 601;
                  tThis.addChild(masks);
                  GXMM.mask = masks;
                  GXBack4 = ComponentUtil.getScaleBitmap("Back_B",[5,5,1,1],tThis,{
                     "x":28,
                     "y":119 - 25,
                     "width":538,
                     "height":334
                  },Global.GXGGdm);
                  GXChuanWen = ComponentUtil.getScaleBitmap("Back_Wen1",[79,11,1,1],tThis,{
                     "x":27,
                     "y":94 - 25,
                     "width":562,
                     "height":23
                  },Global.GXGGdm);
                  GXBCBB = ComponentUtil.getBitmap("Text_BCBB",tThis,{
                     "x":228,
                     "y":94 - 25
                  },Global.GXGGdm);
                  queDingBtn = ComponentUtil.getButton("确定","Button_Four",tThis,{
                     "x":296 - 35,
                     "y":426 - 25,
                     "textColor":16771436
                  },Global.Img_Cdm);
                  queDingBtn.visible = false;
                  queDingBtn.addEventListener(MouseEvent.CLICK,function():void
                  {
                     visible = false;
                     isGxggPan(false);
                  });
                  isLoad = true;
                  isGxggPan(false);
                  if(isGengXinPan)
                  {
                     tabBtn_gxgg.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                  }
               });
            }
            this.mrhd.start();
            if(Model_actDaily.getInstance().hasAct())
            {
               this.mrhdClickHd();
            }
            else
            {
               this.reset();
            }
         }
         else
         {
            this.mrhd.stop();
         }
         super.visible = value;
         tThis = this;
      }
      
      private function isGxggPan(v:Boolean) : void
      {
         if(this.isLoad)
         {
            this.GXMM.visible = v;
            this.GXBCBB.visible = v;
            this.GXBack4.visible = v;
            this.GXChuanWen.visible = v;
            this.queDingBtn.visible = false;
            this.gxgg.visible = v;
         }
      }
      
      public function showPage(index:int) : void
      {
         this.visible = true;
         if(index == 2)
         {
            this.gxggClickHd();
         }
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
         this.tabbtn_mrrw.addEventListener(MouseEvent.CLICK,this.mrrwClickHd);
         this.tabBtn_mrhd.addEventListener(MouseEvent.CLICK,this.mrhdClickHd);
         this.tabBtn_gxgg.addEventListener(MouseEvent.CLICK,this.gxggClickHd);
         this.tf_descript.addEventListener(TextEvent.LINK,this.descpriptClickHd);
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTER_FUBEN,this.onScene);
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTER_SCENE,this.onScene);
      }
      
      private function onScene() : void
      {
         this.visible = false;
      }
      
      private function set type(value:int) : void
      {
         var arr:Array = null;
         if(value == 1)
         {
            arr = this._labelArr;
         }
         else
         {
            arr = this._laberArr2;
         }
         var i:int = 0;
         while(i < this.tf_vec.length)
         {
            this.tf_vec[i].text = LangConfig.getWord(arr[i][0].toString(),2);
            i += 1;
         }
      }
      
      public function mrrwClickHd(evt:MouseEvent = null) : void
      {
         var i:int = 0;
         this.type = 1;
         this.tabbtn_mrrw.choose = true;
         this.tabbtn_mrrw.textColor = 16449280;
         this.mrrw.visible = true;
         this.tabBtn_mrhd.choose = false;
         this.tabBtn_mrhd.textColor = 10611072;
         this.mrhd.visible = false;
         this.gxgg.visible = false;
         this.tabBtn_gxgg.textColor = 10611072;
         i = 0;
         while(i < this.tf_vec.length)
         {
            this.tf_vec[i].visible = true;
            i += 1;
         }
         this.title.visible = true;
         this.isRight = true;
         this.RightVisble();
         this.gridVisble();
         this.isGxggPan(false);
      }
      
      public function cliActionTpe(_type:int) : void
      {
         this.mrhd.actionClihd(_type);
      }
      
      private function mrhdClickHd(evt:MouseEvent = null) : void
      {
         this.type = 2;
         this.tabbtn_mrrw.choose = false;
         this.mrrw.visible = false;
         this.tabbtn_mrrw.textColor = 10611072;
         this.tabBtn_mrhd.choose = true;
         this.tabBtn_mrhd.textColor = 16449280;
         this.mrhd.visible = true;
         this.mrhd.lvHd(GameUnitManager.hero.level);
         this.gxgg.visible = false;
         this.tabBtn_gxgg.textColor = 10611072;
         var i:int = 0;
         while(i < this.tf_vec.length)
         {
            this.tf_vec[i].visible = true;
            i += 1;
         }
         this.title.visible = true;
         this.isRight = true;
         this.RightVisble();
         this.gridVisble();
         this.isGxggPan(false);
      }
      
      public function gxggClickHd(e:MouseEvent = null) : void
      {
         this.type = 3;
         this.tabbtn_mrrw.choose = false;
         this.mrrw.visible = false;
         this.tabbtn_mrrw.textColor = 10611072;
         this.tabBtn_mrhd.choose = false;
         this.tabBtn_mrhd.textColor = 10611072;
         this.mrhd.visible = false;
         this.gxgg.visible = true;
         this.tabBtn_gxgg.textColor = 16449280;
         var i:int = 0;
         while(i < this.tf_vec.length)
         {
            this.tf_vec[i].visible = false;
            i += 1;
         }
         this.title.visible = false;
         this.isRight = false;
         this.RightVisble();
         this.gridVisble();
         this.isGxggPan(true);
         setChildIndex(this.gxgg,numChildren - 1);
      }
      
      private function RightVisble() : void
      {
         if(!this.isRight)
         {
            this.backRight.visible = false;
            this.backLeft.visible = false;
            this.titleRight1.visible = false;
            this.titleRight2.visible = false;
            this.titleRight3.visible = false;
            this.tf_time.visible = false;
            this.tf_descript.visible = false;
         }
         else
         {
            this.backRight.visible = true;
            this.backLeft.visible = true;
            this.titleRight1.visible = true;
            this.titleRight2.visible = true;
            this.titleRight3.visible = true;
            this.tf_time.visible = true;
            this.tf_descript.visible = true;
         }
      }
      
      public function set actDescript(value:String) : void
      {
         this.tf_descript.htmlText = value;
      }
      
      public function set timeDescript(value:String) : void
      {
         this.tf_time.align = TextFormatAlign.CENTER;
         if(value.length <= 8)
         {
            this.tf_time.htmlText = "<font size=\'16\'>" + value + "</font>";
         }
         else
         {
            this.tf_time.text = value;
         }
      }
      
      public function set gridVoArr(arr:Array) : void
      {
         var i:int = 0;
         while(i < 6)
         {
            if(Boolean(arr[i]))
            {
               this._gridVec[i].vo = arr[i];
            }
            else
            {
               this._gridVec[i].vo = null;
            }
            i += 1;
         }
      }
   }
}

