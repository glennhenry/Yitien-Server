package com.yiTian.view.modules.jingJiChang
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_jingJiChang;
   import com.yiTian.data.vo.Vo_jingJiChang;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFormatAlign;
   
   public class View_paiMing extends Panel
   {
      
      public static const EXPANDLEN:int = 30;
      
      public var Page_text:MyTextField;
      
      private var Button_PageUp:Button;
      
      private var Button_PageDown:Button;
      
      public var dataArr:Array = [];
      
      private var _curPage:int = 1;
      
      public var totalPage:int;
      
      private var bmTitle:Bitmap = new Bitmap();
      
      public function View_paiMing()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var i:int = 0;
         var Item_PM:View_item_paiMing = null;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":308 + EXPANDLEN,
            "height":425
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":260 + EXPANDLEN,
            "height":350
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":26,
            "y":42,
            "width":256 + EXPANDLEN,
            "height":20
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":199 + EXPANDLEN,
            "y":395,
            "width":60,
            "height":20
         },Global.Img_Cdm);
         move = new Rectangle(0,0,278 + EXPANDLEN,38);
         this.Page_text = ComponentUtil.getTextField("1/10",this,{
            "x":213 + EXPANDLEN,
            "y":395,
            "color":16184781,
            "size":12,
            "leading":0
         });
         this.Page_text.align = TextFormatAlign.CENTER;
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":274 + EXPANDLEN,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_PageUp = ComponentUtil.getButton("","Button_PageLeft",this,{
            "x":176 + EXPANDLEN,
            "y":395,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_PageDown = ComponentUtil.getButton("","Button_PageRight",this,{
            "x":261 + EXPANDLEN,
            "y":395,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_PageUp.name = "down";
         this.Button_PageDown.name = "up";
         this.Button_PageUp.addEventListener(MouseEvent.CLICK,this.changedHandle);
         this.Button_PageDown.addEventListener(MouseEvent.CLICK,this.changedHandle);
         i = 0;
         while(i <= 9)
         {
            Item_PM = new View_item_paiMing();
            Item_PM.x = 28;
            Item_PM.y = 65 + i * 32;
            addChild(Item_PM);
            this.dataArr.push(Item_PM);
            Item_PM.visible = false;
            Item_PM = null;
            i++;
         }
         ComponentUtil.getTextField(LangConfig.getWord("60166",6),this,{
            "x":50,
            "y":42
         });
         ComponentUtil.getTextField(LangConfig.getWord("60167",6),this,{
            "x":110 + EXPANDLEN - 5,
            "y":42
         });
         ComponentUtil.getTextField(LangConfig.getWord("60004",6),this,{
            "x":188 + EXPANDLEN - 2,
            "y":42
         });
         ComponentUtil.getTextField(LangConfig.getWord("60023",6),this,{
            "x":235 + EXPANDLEN,
            "y":42
         });
      }
      
      private function changedHandle(e:MouseEvent) : void
      {
         var temBtn:Button = e.target as Button;
         if(temBtn.name == "up")
         {
            ++this._curPage;
            if(this._curPage > this.totalPage)
            {
               this._curPage = this.totalPage;
            }
         }
         else
         {
            --this._curPage;
            if(this._curPage < 1)
            {
               this._curPage = 1;
            }
         }
         this.Page_text.text = String(this._curPage) + "/" + this.totalPage;
         this.updata(this._curPage);
      }
      
      public function updata(curPage:int) : void
      {
         var temData:View_item_paiMing = null;
         var vo_jingjiChang:Vo_jingJiChang = null;
         var i:int = 0;
         var temNum:int = 0;
         var j:int = 0;
         while(j <= 9)
         {
            this.dataArr[j].visible = false;
            j++;
         }
         if(curPage != this.totalPage)
         {
            i = 0;
            while(i <= 9)
            {
               temData = this.dataArr[i];
               vo_jingjiChang = Model_jingJiChang.jjc_paihang[i + (curPage - 1) * 10];
               temData.visible = true;
               temData._job = vo_jingjiChang.job;
               temData.playerName = vo_jingjiChang.role_name;
               temData.level = vo_jingjiChang.level;
               temData.pai_ming = vo_jingjiChang.pai_ming;
               temData._roleId = vo_jingjiChang.roldId;
               temData._sex = vo_jingjiChang.sex;
               temData._petId = vo_jingjiChang.pet_id;
               temData._pet_icon = vo_jingjiChang.pet_icon;
               temData.hr_pos = vo_jingjiChang.hero_position;
               temData.pet_pos = vo_jingjiChang.pet_position;
               i++;
            }
         }
         else
         {
            if(Model_jingJiChang.jjc_paihang.length % 10 == 0)
            {
               temNum = 10;
            }
            else
            {
               temNum = Model_jingJiChang.jjc_paihang.length % 10;
            }
            i = 0;
            while(i < temNum)
            {
               temData = this.dataArr[i];
               vo_jingjiChang = Model_jingJiChang.jjc_paihang[i + (curPage - 1) * 10];
               temData.visible = true;
               temData._job = vo_jingjiChang.job;
               temData.playerName = vo_jingjiChang.role_name;
               temData.level = vo_jingjiChang.level;
               temData.pai_ming = vo_jingjiChang.pai_ming;
               temData._roleId = vo_jingjiChang.roldId;
               temData._sex = vo_jingjiChang.sex;
               temData._petId = vo_jingjiChang.pet_id;
               temData._pet_icon = vo_jingjiChang.pet_icon;
               temData.hr_pos = vo_jingjiChang.hero_position;
               temData.pet_pos = vo_jingjiChang.pet_position;
               i++;
            }
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(!this.bmTitle.bitmapData)
            {
               Utils.loadTitle("lang/ch/Arena_Imgs.swf","Title_ArenaPaiMing",this.bmTitle,{
                  "x":74,
                  "y":5
               },this);
            }
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

