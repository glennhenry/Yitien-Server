package com.yiTian.view.modules.panel
{
   import com.event.Button_h;
   import com.event.TextField_h;
   import com.utils.ColorConstant;
   import com.yiTian.Global;
   import com.yiTian.data.config.valuable.Enum_color;
   import com.yiTian.data.config.valuable.Enum_filter;
   import com.yiTian.data.config.valuable.Enum_item_type;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.BagCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.bag.View_panel;
   import com.yiTian.view.modules.role.View_role_meridian;
   import flash.events.MouseEvent;
   
   public class View_panel_updateTip extends View_panel
   {
      
      private static const SIZE_TF_NAME:int = 14;
      
      private var btn_ok:Button_h;
      
      private var view_grid:View_Grid;
      
      private var tf_name:TextField_h;
      
      private var tf_tip:TextField_h;
      
      private var arr_vo:Array;
      
      public function View_panel_updateTip()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
      }
      
      override protected function initDynamicView() : void
      {
         this.arr_vo = [];
      }
      
      private function getItemNum(id:int) : int
      {
         var _nn:int = 0;
         var i:int = 0;
         var _ttVo:Vo_valuable = null;
         var Dvec:Vector.<Vo_valuable> = CommandManager.get_bag_vec(Enum_filter.ID,null,[id]);
         if(Boolean(Dvec))
         {
            i = 0;
            while(i < Dvec.length)
            {
               _ttVo = Dvec[i];
               _nn += _ttVo.count;
               i++;
            }
         }
         return _nn;
      }
      
      private function compareWith(_num:int, _numArr:Array) : Boolean
      {
         var i:int = 0;
         var _nn:int = 0;
         if(Boolean(_numArr))
         {
            i = 0;
            while(i < _numArr.length)
            {
               _nn = int(_numArr[i]);
               if(_num >= _nn && _nn != 0)
               {
                  return true;
               }
               i++;
            }
         }
         return false;
      }
      
      public function update(vo:Vo_valuable) : void
      {
         var pan:View_role_meridian = null;
         var arr:Array = null;
         var bagN:int = 0;
         var boo:Boolean = false;
         var _voI:Vo_valuable = null;
         if(vo.id == 46260)
         {
            pan = UIManager.rolePanel.view_role_meridian;
            arr = pan.needs;
            bagN = this.getItemNum(46260);
            boo = this.compareWith(bagN,arr);
            if(!boo)
            {
               return;
            }
         }
         if(Global.pf == "qqgame")
         {
            if(vo.id == 46415)
            {
               return;
            }
         }
         else if(vo.id == 46463)
         {
            return;
         }
         if(Boolean(View_updata_panelTip.voArrVec.length))
         {
            for each(_voI in View_updata_panelTip.voArrVec)
            {
               if(_voI == vo)
               {
                  return;
               }
            }
         }
         View_updata_panelTip.getInstance().updata_vo(vo);
      }
      
      override public function resetPosition() : void
      {
         x = Global.stage.stageWidth * 0.7;
         y = Global.stage.stageHeight * 0.62;
      }
      
      private function comp() : void
      {
         super.visible = true;
      }
      
      override public function set visible(value:Boolean) : void
      {
         var len:int = 0;
         if(value)
         {
            super.visible = true;
         }
         else
         {
            this.arr_vo.pop();
            len = int(this.arr_vo.length);
            if(len > 0)
            {
               this.Show(this.arr_vo[len - 1]);
            }
            else
            {
               super.visible = false;
            }
         }
      }
      
      private function Show(vo:Vo_valuable) : void
      {
         var str:String = null;
         this.visible = true;
         if(vo.color == Enum_color.WHITE)
         {
            str = ColorConstant.getColorStr(ColorConstant.WHITE);
         }
         else if(vo.color == Enum_color.GREEN)
         {
            str = ColorConstant.getColorStr(ColorConstant.GREEN);
         }
         else if(vo.color == Enum_color.BLUE)
         {
            str = ColorConstant.getColorStr(ColorConstant.BLUE);
         }
         else if(vo.color == Enum_color.PURPLE)
         {
            str = ColorConstant.getColorStr(ColorConstant.PURPLE);
         }
         else if(vo.color == Enum_color.ORANGE)
         {
            str = ColorConstant.getColorStr(ColorConstant.ORANGE);
         }
         else if(vo.color == Enum_color.ANJIN)
         {
            str = ColorConstant.getColorStr(ColorConstant.ANJIN);
         }
         this.tf_name.htmlText = HtmlUtil.font(vo.str_name,str,SIZE_TF_NAME);
         this.view_grid.vo = vo;
         if(vo is Vo_equip)
         {
            this.btn_ok.set_htmlText(LangConfig.getWord("921",0));
            this.tf_tip.htmlText = LangConfig.getWord("922",0);
         }
         else if(vo.type == Enum_item_type.BOOK_SKILL)
         {
            this.btn_ok.set_htmlText(LangConfig.getWord("923",0));
            this.tf_tip.htmlText = LangConfig.getWord("924",0);
         }
         else if(vo.type == Enum_item_type.BOOK_SKILL_UP)
         {
            this.btn_ok.set_htmlText(LangConfig.getWord("925",0));
            this.tf_tip.htmlText = LangConfig.getWord("926",0);
         }
         else if(vo.type == Enum_item_type.MERIDIAN_PILL)
         {
            if(!UIManager.rolePanel.view_role_meridian.isCan())
            {
               super.visible = false;
               return;
            }
            this.btn_ok.set_htmlText(LangConfig.getWord("927",0));
            this.tf_tip.htmlText = LangConfig.getWord("928",0);
         }
         else
         {
            this.btn_ok.set_htmlText(LangConfig.getWord("929",0));
            this.tf_tip.htmlText = LangConfig.getWord("930",0);
         }
      }
      
      private function CLICK_BTN_OK(e:MouseEvent) : void
      {
         var vo:Vo_valuable = null;
         vo = this.arr_vo[this.arr_vo.length - 1] as Vo_valuable;
         if(vo is Vo_equip)
         {
            BagCGMessage.CG_BAG_EQUIP_ID_SERVER(vo.id_server);
         }
         else if(vo is Vo_item)
         {
            if(vo.type == Enum_item_type.BOOK_SKILL_UP)
            {
               UIManager.skillPanel.visible = true;
               UIManager.skillPanel.update_choose(vo);
            }
            else if(vo.type == Enum_item_type.MERIDIAN_PILL)
            {
               UIManager.rolePanel.openView(Enum_panel_role.MERIDIAN);
            }
            else if(vo.type == Enum_item_type.FUYUAN_WAWA)
            {
               BagCGMessage.CG_BAG_REDUCE(BagCGMessage.USE_ITEM,vo.gridId,1);
            }
            else
            {
               BagCGMessage.CG_BAG_ITEM_ID(vo.id,vo.bBind ? 1 : 0);
            }
         }
         this.visible = false;
      }
   }
}

