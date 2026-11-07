package com.yiTian.view.modules.WulinDaHui
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_WlDahui;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.net.message.cg.WulinPartyCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.view.Panel;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class WuLinPaiHang extends Panel
   {
      
      private static var isLoad:Boolean = false;
      
      private var Button_PageBack:Button;
      
      private var Button_PageNext:Button;
      
      private var mm_txt:MyTextField;
      
      private var playerName_txt:MyTextField;
      
      private var selfScore_txt:MyTextField;
      
      private var paiMing_txt:MyTextField;
      
      private var WDJiFen_text:MyTextField;
      
      private var wlPaiHang_items:Items_wlDahui;
      
      private var items_arr:Array = [];
      
      private var temNum:int = 1;
      
      private var maxPage:int = 1;
      
      private var last:int;
      
      private var left_num:int;
      
      private var _len:int;
      
      public function WuLinPaiHang()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var i:int = 0;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":318,
            "height":445
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":24,
            "y":40,
            "width":270,
            "height":370
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":25,
            "y":41,
            "width":268,
            "height":22
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":209,
            "y":415,
            "width":60,
            "height":20
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("60001",6),this,{
            "x":34,
            "y":42,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60363",6),this,{
            "x":125,
            "y":42,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("60187",6),this,{
            "x":250,
            "y":42,
            "color":16764206,
            "size":12,
            "leading":0
         });
         move = new Rectangle(0,0,288,38);
         this.playerName_txt = ComponentUtil.getTextField(LangConfig.getWord("892",0),this,{
            "x":125,
            "y":42,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.selfScore_txt = ComponentUtil.getTextField(LangConfig.getWord("893",0),this,{
            "x":250,
            "y":42,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.paiMing_txt = ComponentUtil.getTextField(LangConfig.getWord("894",0),this,{
            "x":34,
            "y":42,
            "color":16764206,
            "size":12,
            "leading":0
         });
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":286,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_PageNext = ComponentUtil.getButton("","Button_PageLeft",this,{
            "x":185,
            "y":415,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_PageBack = ComponentUtil.getButton("","Button_PageRight",this,{
            "x":272,
            "y":415,
            "textColor":16184781
         },Global.Img_Cdm);
         this.WDJiFen_text = ComponentUtil.getTextField(LangConfig.getWord("895",0),this,{
            "x":34,
            "y":415,
            "color":16764206
         });
         this.mm_txt = ComponentUtil.getTextField("1/1",this,{
            "x":221,
            "y":415,
            "color":16764206
         });
         this.Button_PageNext.name = "up";
         this.Button_PageBack.name = "down";
         i = 0;
         while(i < 12)
         {
            this.wlPaiHang_items = new Items_wlDahui();
            this.wlPaiHang_items.x = 35;
            this.wlPaiHang_items.y = 67 + i * 26;
            addChild(this.wlPaiHang_items);
            this.wlPaiHang_items.visible = false;
            this.items_arr.push(this.wlPaiHang_items);
            i++;
         }
         this.Button_PageBack.addEventListener(MouseEvent.CLICK,this.chanHandle);
         this.Button_PageNext.addEventListener(MouseEvent.CLICK,this.chanHandle);
      }
      
      private function chanHandle(e:MouseEvent) : void
      {
         var temBtn:Button = e.target as Button;
         if(temBtn.name == "up")
         {
            ++this.temNum;
            if(this.temNum > this.maxPage)
            {
               this.temNum = this.maxPage;
            }
         }
         else
         {
            --this.temNum;
            if(this.temNum < 1)
            {
               this.temNum = 1;
            }
         }
         this.mm_txt.text = String(this.temNum) + "/" + String(this.maxPage);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            WulinPartyCGMessage.CG_GET_PAIHANG_DATA();
            GameScene.instance.addFrameCallBack(this.framHandle);
            if(!Global.WLDaHui_Imgsdm)
            {
               SingleLoader.add("lang/ch/WLDaHui_Imgs.swf",function(info:Object):void
               {
                  Global.WLDaHui_Imgsdm = info.applicationDomain;
                  addBmp();
               });
            }
            else if(!isLoad)
            {
               this.addBmp();
            }
         }
         else
         {
            GameScene.instance.removeFrameCallBack(this.framHandle);
         }
      }
      
      private function addBmp() : void
      {
         isLoad = true;
         ComponentUtil.getBitmap("Title_WLDHRank",this,{
            "x":59,
            "y":5
         },Global.WLDaHui_Imgsdm);
      }
      
      private function framHandle(interenal:int) : void
      {
         var now:int = getTimer();
         if(now - this.last >= 10000)
         {
            WulinPartyCGMessage.CG_GET_PAIHANG_DATA();
            this.last = now;
         }
      }
      
      private function reset() : void
      {
         var temItems:Items_wlDahui = null;
         var i:int = 0;
         while(i < this.items_arr.length)
         {
            temItems = this.items_arr[i];
            temItems.visible = false;
            i++;
         }
      }
      
      public function update(_arr:Array) : void
      {
         var temItems:Items_wlDahui = null;
         var temVoWL:Vo_WlDahui = null;
         var i:int = 0;
         this.reset();
         i = 0;
         while(i < _arr.length)
         {
            temItems = this.items_arr[i];
            temItems.visible = true;
            temVoWL = _arr[i];
            temItems.update(temVoWL);
            i++;
         }
      }
      
      public function update_self(len:int, selfScore:int, temArr:Array) : void
      {
         this._len = len;
         this.mm_txt.text = "1/" + String(this.maxPage);
         this.WDJiFen_text.text = LangConfig.getWord("888",0) + String(selfScore);
         this.update(temArr);
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.data.model.Model_heFu;
import com.yiTian.data.vo.Vo_WlDahui;
import com.yiTian.manager.LangConfig;
import flash.display.Sprite;
import flash.text.TextFormatAlign;

class Items_wlDahui extends Sprite
{
   
   private var Name_text:MyTextField;
   
   private var JiFen_text:MyTextField;
   
   private var Rank_text:MyTextField;
   
   public function Items_wlDahui()
   {
      super();
      ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
         "x":0,
         "y":23,
         "width":250,
         "height":2
      },Global.Img_Cdm);
      this.Name_text = ComponentUtil.getTextField(LangConfig.getWord("896",0),this,{
         "x":78,
         "y":2,
         "color":16184781,
         "realWidth":76.2
      });
      this.Name_text.align = TextFormatAlign.CENTER;
      this.JiFen_text = ComponentUtil.getTextField("10000",this,{
         "x":183,
         "y":2,
         "color":16184781
      });
      this.JiFen_text.align = TextFormatAlign.CENTER;
      this.Rank_text = ComponentUtil.getTextField("1",this,{
         "x":5,
         "y":2,
         "color":16184781,
         "realWidth":36.3
      });
      this.Rank_text.align = TextFormatAlign.CENTER;
   }
   
   public function update(vo_wl:Vo_WlDahui) : void
   {
      vo_wl.role_name = Model_heFu.repNameByHero(vo_wl.role_name);
      this.Name_text.text = vo_wl.role_name;
      this.JiFen_text.text = String(vo_wl.role_jifen);
      this.Rank_text.text = String(vo_wl.paiming);
   }
}
