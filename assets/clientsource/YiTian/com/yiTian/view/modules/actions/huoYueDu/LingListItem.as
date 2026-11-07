package com.yiTian.view.modules.actions.huoYueDu
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.ActionsCGMessage;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class LingListItem extends Sprite
   {
      
      private var gridVec:Vector.<View_Grid> = new Vector.<View_Grid>(5);
      
      private var btnGet:Button;
      
      private var tfHuoYueDu:MyTextField;
      
      private var tfGot:Bitmap;
      
      private var _typeArr:Array = ["20","40","60","80","100"];
      
      private var _typeHuoYue:int;
      
      public function LingListItem()
      {
         var grid:View_Grid = null;
         super();
         ComponentUtil.getBitmap("List_Back",this,{
            "x":0,
            "y":0
         },Global.HuoYue_Imgsdm);
         this.btnGet = ComponentUtil.getButton("领取","Button_GreenTwo28",this,{
            "x":231,
            "y":13,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btnGet.addEventListener(MouseEvent.CLICK,this.cliHd);
         var i:int = 0;
         while(i < this.gridVec.length)
         {
            grid = new View_Grid();
            grid.set_bmp_bg();
            grid.set_bmp_over(true,null);
            grid.set_tf_count(true,false,true);
            ComponentUtil.setPropertie(grid,{
               "x":7 + 43 * i,
               "y":9
            });
            addChild(grid);
            this.gridVec[i] = grid;
            i++;
         }
         this.tfHuoYueDu = ComponentUtil.getTextField("活跃度000",this,{
            "x":229,
            "y":16,
            "color":58918,
            "size":12,
            "leading":0,
            "bold":true
         });
         this.tfGot = ComponentUtil.getBitmap("Text_Got",this,{
            "x":234,
            "y":7
         },Global.HuoYue_Imgsdm);
      }
      
      private function cliHd(e:MouseEvent) : void
      {
         var num:int = CommandManager.get_bag_canUse() - CommandManager.get_bag_used();
         if(num < this._typeHuoYue)
         {
            UIManager.centerBroadcast.addMsg("背包格子不够，请清理背包");
            return;
         }
         ActionsCGMessage.CG_HUOYUEDU_GETAWARD(this._typeHuoYue);
      }
      
      private function reset() : void
      {
         var grid:View_Grid = null;
         this.btnGet.visible = false;
         this.tfHuoYueDu.visible = false;
         this.tfGot.visible = false;
         for each(grid in this.gridVec)
         {
            grid.visible = false;
         }
      }
      
      public function update(_type:int, _status:int) : void
      {
         var ds:String = null;
         var gd:View_Grid = null;
         var _a:Array = null;
         var _typ:int = 0;
         var _voI:Vo_item = null;
         var _voE:Vo_equip = null;
         this.reset();
         this._typeHuoYue = _type + 1;
         if(_status == 1)
         {
            this.btnGet.visible = true;
         }
         else if(_status == 2)
         {
            this.tfGot.visible = true;
         }
         else
         {
            this.tfHuoYueDu.visible = true;
            this.tfHuoYueDu.text = "活跃度" + this._typeArr[_type];
         }
         var ss:String = Data_lib.huoYueDuAward[_type + 1][1];
         var arr:Array = ss.split(",");
         var i:int = 0;
         while(i < arr.length)
         {
            ds = arr[i];
            gd = this.gridVec[i];
            gd.visible = true;
            _a = ds.split("_");
            _typ = int(_a[0]);
            if(_typ == 1)
            {
               _voI = new Vo_item();
               _voI.id = _a[1];
               _voI.count = _a[2];
               _voI.Init_lib();
               gd.vo = _voI;
            }
            else if(_typ == 2)
            {
               _voE = new Vo_equip();
               _voE.id = _a[1];
               _voE.count = _a[2];
               _voE.Init_lib();
               gd.vo = _voE;
            }
            i++;
         }
      }
      
      public function getAward() : void
      {
         var grid:View_Grid = null;
         this.tfGot.visible = true;
         this.tfHuoYueDu.visible = false;
         this.btnGet.visible = false;
         HuoYueMter.dataArrM[this._typeHuoYue - 1] = 2;
         HuoYueDuTip.instance.handle(HuoYueMter.dataArrM);
         for each(grid in this.gridVec)
         {
            if(grid.visible)
            {
               ComboTweenStep.toBag(grid);
            }
         }
      }
   }
}

