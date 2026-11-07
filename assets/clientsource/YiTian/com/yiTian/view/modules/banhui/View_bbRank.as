package com.yiTian.view.modules.banhui
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.net.message.cg.BangBattleCGMessage;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.loading.View_loading;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   
   public class View_bbRank extends Panel
   {
      
      private var bg:DisplayObjectContainer;
      
      private var bg_name:DisplayObject;
      
      private var itemVec:Array;
      
      private var Y1:Number = 69;
      
      private var offsetY:Number = 26;
      
      private var X1:Number = 35;
      
      private var isUIComplete:Boolean = false;
      
      public function View_bbRank()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         this.bg = new Sprite();
         this.bg.mouseChildren = false;
         addChild(this.bg);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this.bg,{
            "x":0,
            "y":0,
            "width":318,
            "height":425
         },Global.Img_Cdm);
         move = new Rectangle(0,0,this.bg.width,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":width - 40,
            "y":4
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("29067",2),this,{
            "x":38,
            "y":42,
            "color":10338946
         });
         ComponentUtil.getTextField(LangConfig.getWord("29068",2),this,{
            "x":105,
            "y":42,
            "color":10338946
         });
         ComponentUtil.getTextField(LangConfig.getWord("29069",2) + "/" + LangConfig.getWord("29403",2),this,{
            "x":175,
            "y":42,
            "color":10338946
         });
      }
      
      override protected function initDynamicView() : void
      {
         this.itemVec = [];
         super.initDynamicView();
      }
      
      public function update(arr:Array, bArr:Array) : void
      {
         var i:int = 0;
         var it:Item = null;
         Item.bArr = bArr;
         i = 0;
         while(i < arr.length)
         {
            if(!this.itemVec[i])
            {
               it = new Item();
               it.x = this.X1;
               it.y = this.Y1 + this.offsetY * i;
               it.rank = i + 1;
               addChild(it);
               this.itemVec.push(it);
            }
            if(Boolean(arr[i]))
            {
               this.itemVec[i].visible = true;
               this.itemVec[i].obj = arr[i];
            }
            else
            {
               this.itemVec[i].visible = false;
            }
            i += 1;
         }
         var j:int = i;
         while(j < this.itemVec.length)
         {
            this.itemVec[j].visible = false;
            j += 1;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         var arr:Array = null;
         if(value)
         {
            BangBattleCGMessage.CG_BB_RANKS();
            if(!this.isUIComplete)
            {
               if(!Global.bangzhan_Imsdm)
               {
                  arr = [];
                  arr.push(["lang/ch/BangZhan_Imgs.swf",function(info:Object):void
                  {
                     Global.bangzhan_Imsdm = info.applicationDomain;
                  },LangConfig.getWord("20000",2),Enum_loaderType.SINGLE,Enum_resType.RES_URL]);
                  View_loading.instance.load(arr,function():void
                  {
                     initT();
                     visible = true;
                     View_loading.instance.visible = false;
                  });
                  return;
               }
               this.initT();
            }
         }
         super.visible = value;
      }
      
      private function initT() : void
      {
         this.isUIComplete = true;
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this.bg,{
            "x":24,
            "y":40,
            "width":270,
            "height":370
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this.bg,{
            "x":25,
            "y":41,
            "width":268,
            "height":22
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("60034",6),this.bg,{
            "x":125,
            "y":7,
            "color":16750899,
            "size":16,
            "bold":true
         });
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

import Layout.VGroup;
import com.ui.controls.MyTextField;
import com.utils.ColorConstant;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.command.Enum_MsgType;
import com.yiTian.utils.Bitmap2;
import com.yiTian.utils.HtmlUtil;
import com.yiTian.view.modules.banhui.View_BangBattleRanks;
import flash.display.Sprite;
import flash.events.TextEvent;
import flash.text.TextFieldAutoSize;

class Item extends Sprite
{
   
   public static var bArr:Array;
   
   private var tf_rank:MyTextField;
   
   private var tf_name:MyTextField;
   
   private var tf_sc:MyTextField;
   
   private var role_id:int;
   
   private var bmVGroup:VGroup = new VGroup(195,3,0,0,0,22);
   
   private var bmArr:Array = [];
   
   public function Item()
   {
      super();
      ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
         "x":0,
         "y":23,
         "width":250,
         "height":2
      },Global.Img_Cdm);
      this.tf_rank = ComponentUtil.getTextField("",this,{
         "x":25,
         "y":3,
         "realWidth":0,
         "color":14540032
      });
      this.tf_rank.autoSize = TextFieldAutoSize.CENTER;
      this.tf_name = ComponentUtil.getTextField("",this,{
         "x":95,
         "y":3,
         "realWidth":0,
         "color":43520
      });
      this.tf_name.autoSize = TextFieldAutoSize.CENTER;
      this.tf_sc = ComponentUtil.getTextField("",this,{
         "x":187,
         "y":3,
         "realWidth":0,
         "color":14483456
      });
      this.tf_sc.autoSize = TextFieldAutoSize.RIGHT;
   }
   
   public function set rank(value:int) : void
   {
      this.tf_rank.text = value.toString();
   }
   
   private function linkHd(evt:TextEvent) : void
   {
      Global.control.sendNotification(Enum_MsgType.MSG_CHECKOTHERROLE,this.role_id);
   }
   
   public function set obj(value:Object) : void
   {
      var color:int = 0;
      var bm:Bitmap2 = null;
      var j:int = 0;
      var zbID:int = 0;
      var bmm:Bitmap2 = null;
      var rank:int = int(value.rank);
      if(rank <= 1)
      {
         color = ColorConstant.PURPLE;
      }
      else if(rank <= 3)
      {
         color = ColorConstant.BLUE;
      }
      else if(rank <= 6)
      {
         color = ColorConstant.GREEN;
      }
      else
      {
         color = ColorConstant.WHITE;
      }
      var bang_id:int = int(value.bangId);
      var bangName:String = value.bangName;
      var soccer:int = int(value.soccer);
      for each(bm in this.bmArr)
      {
         removeChild(bm);
         bm.load(null);
      }
      this.bmArr.splice(0);
      this.bmVGroup.clearItem();
      j = 0;
      while(j < bArr.length)
      {
         zbID = int(bArr[j]);
         if(zbID == bang_id)
         {
            bmm = new Bitmap2();
            bmm.load(View_BangBattleRanks.bmDirs[j]);
            this.bmVGroup.appendItem(bmm);
            this.bmArr.push(bmm);
            addChild(bmm);
         }
         j += 1;
      }
      this.bmVGroup.align();
      this.tf_rank.color = ColorConstant.getColorInt(color);
      this.tf_name.htmlText = HtmlUtil.fontNoSize(bangName,ColorConstant.getColorStr(color));
      this.tf_sc.htmlText = HtmlUtil.fontNoSize(soccer.toString(),ColorConstant.getColorStr(color));
   }
}
