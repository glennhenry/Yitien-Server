package com.yiTian.view.modules.newerGuide
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel123;
   import flash.display.Bitmap;
   import flash.geom.Rectangle;
   import flashx.textLayout.formats.TextAlign;
   
   public class ChildNewerGuidePan extends Panel123
   {
      
      public static var sourceTxt:Array = ["Text_ChongWu","Text_ShenGong","Text_ZuoQi","Text_JingMai","Text_QiangHua","Text_NeiGong","Text_BangHui"];
      
      public static var sourceImg:Array = ["Img_ChongWu","Img_ShenGong","Img_ZuoQi","Img_JingMai","Img_QiangHua","Img_NeiGong","Img_BangHui"];
      
      public static var sourceTitle:Array = ["Title_ChongWu","Title_ShenGong","Title_ZuoQi","Title_JingMai","Title_QiangHua","Title_NeiGong","Title_BangHui"];
      
      private static var _modeArr:Array = [];
      
      private var txtBm:Bitmap;
      
      private var imgBm:Bitmap;
      
      private var titleBm:Bitmap;
      
      private var tfDes1:MyTextField;
      
      private var tfDes2:MyTextField;
      
      private var tfDes3:MyTextField;
      
      private var tfDes4:MyTextField;
      
      private var movePart:Child_bmp;
      
      private var bmp:Bitmap;
      
      private var posArr:Array = [[-184,-130],[-67,-134],[-145,-264],[-92,-169]];
      
      public function ChildNewerGuidePan()
      {
         super();
         regResource("lang/ch/XSYinDao.swf","XSYinDaodm");
      }
      
      private static function get modeArr() : Array
      {
         var inerId:int = 0;
         if(!_modeArr.length)
         {
            inerId = int(Enum_job.getBaseJob(GameUnitManager.hero.job));
            _modeArr = ["modelRes/role/body/run/20901.swf","modelRes/magic/" + "3" + inerId + "901.swf","modelRes/role/horse/stand/24501.swf"];
         }
         return _modeArr;
      }
      
      override protected function initUI2() : void
      {
         ComponentUtil.getBitmap("Back_Img",this,{
            "x":0,
            "y":0
         },Global.XSYinDaodm);
         move = new Rectangle(0,70,800,250);
         this.txtBm = ComponentUtil.getBitmap("Text_ChongWu",this,{
            "x":309,
            "y":61
         },Global.XSYinDaodm);
         this.imgBm = ComponentUtil.getBitmap("Img_ChongWu",this,{
            "x":130,
            "y":70
         },Global.XSYinDaodm);
         if(!this.bmp)
         {
            this.bmp = new Bitmap();
            addChild(this.bmp);
         }
         this.tfDes1 = ComponentUtil.getTextField("1、宠物资质越高，初始属性增加的越多。\n2、宠物成长等级越高，技能槽数量增加的越多。\n3、宠物内丹使用后可大幅提升宠物属性值。",this,{
            "x":141,
            "y":262,
            "color":10092381,
            "size":12,
            "leading":4,
            "multiline":true,
            "wordWrap":true,
            "realWidth":290
         });
         this.tfDes2 = ComponentUtil.getTextField("    在闯荡江湖中一路班尼成长的是宠物，宠物在\n战斗中还可以达到力挽狂澜的作用。\n    宠物还可以学习技能， 战斗中可触发技能一击\n击杀对方。",this,{
            "x":454,
            "y":107,
            "color":13424242,
            "size":12,
            "leading":6,
            "multiline":true,
            "wordWrap":true,
            "realWidth":290
         });
         this.tfDes3 = ComponentUtil.getTextField("4级后自动开启",this,{
            "x":454,
            "y":228,
            "color":12582720,
            "size":12,
            "leading":0,
            "realWidth":284,
            "align":TextAlign.CENTER
         });
         this.tfDes4 = ComponentUtil.getTextField("力挽狂澜，一击必杀",this,{
            "x":454,
            "y":304,
            "color":12582720,
            "size":12,
            "leading":0,
            "realWidth":284,
            "align":TextAlign.CENTER
         });
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":753,
            "y":81,
            "textColor":16184781
         },Global.XSYinDaodm);
         initDynamicView();
         this.titleBm = ComponentUtil.getBitmap("Title_ChongWu",this,{
            "x":103,
            "y":5
         },Global.XSYinDaodm);
         ComponentUtil.getBitmap("TiYan_Img",this,{
            "x":153,
            "y":112
         },Global.XSYinDaodm);
      }
      
      public function showPart(_part:int) : void
      {
         var job:int = 0;
         if(!visible)
         {
            this.visible = true;
         }
         this.txtBm.bitmapData = ComponentUtil.getBitmapData(sourceTxt[_part],Global.XSYinDaodm);
         this.imgBm.bitmapData = ComponentUtil.getBitmapData(sourceImg[_part],Global.XSYinDaodm);
         this.titleBm.bitmapData = ComponentUtil.getBitmapData(sourceTitle[_part],Global.XSYinDaodm);
         this.tfDes1.htmlText = Data_lib.newerDescrip[_part + 1][0];
         this.tfDes2.htmlText = Data_lib.newerDescrip[_part + 1][1];
         this.tfDes3.htmlText = Data_lib.newerDescrip[_part + 1][2];
         this.tfDes4.htmlText = Data_lib.newerDescrip[_part + 1][3];
         if(Boolean(this.movePart))
         {
            this.movePart.removeFrame();
         }
         if(_part == 0 || _part == 2)
         {
            if(!this.movePart)
            {
               this.movePart = new Child_bmp();
               this.movePart._way = 4;
               this.movePart.init(modeArr[_part]);
               this.movePart.addFrame();
               addChild(this.movePart);
            }
            else if(!this.movePart.visible)
            {
               this.movePart._way = 4;
               this.movePart.init(_modeArr[_part]);
               this.movePart.addFrame();
            }
            if(_part == 2)
            {
               ComponentUtil.setPropertie(this.movePart,{
                  "x":220 + 36,
                  "y":150 + 110
               });
            }
            else
            {
               ComponentUtil.setPropertie(this.movePart,{
                  "x":220 + 36,
                  "y":150 + 80
               });
            }
            if(Boolean(this.bmp))
            {
               this.bmp.visible = false;
            }
         }
         else if(_part == 1)
         {
            job = int(Enum_job.getBaseJob(GameUnitManager.hero.job));
            Utils.getLoadBitmap("resource/image/gnkq/job_" + job + ".png",this.bmp,{
               "x":250 + this.posArr[job - 1][0],
               "y":190 + this.posArr[job - 1][1]
            });
            if(Boolean(this.bmp))
            {
               this.bmp.visible = true;
            }
         }
         else
         {
            if(Boolean(this.movePart))
            {
               this.movePart.removeFrame();
            }
            if(Boolean(this.bmp))
            {
               this.bmp.visible = false;
            }
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(!value)
         {
            if(Boolean(this.movePart))
            {
               this.movePart.removeFrame();
            }
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 790) / 2;
         y = (Global.stage.stageHeight - 385) / 2;
      }
   }
}

