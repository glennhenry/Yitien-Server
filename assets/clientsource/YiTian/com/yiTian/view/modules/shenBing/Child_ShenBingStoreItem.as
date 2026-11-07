package com.yiTian.view.modules.shenBing
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.valuable.Enum_lib_item;
   import com.yiTian.data.vo.Vo_grid;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.net.message.cg.ShenBingCGMessage;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class Child_ShenBingStoreItem extends Sprite
   {
      
      private var _grid:View_Grid;
      
      private var _tfNumItemNeed:MyTextField;
      
      public var btn:Button;
      
      private var _cost:int;
      
      public function Child_ShenBingStoreItem()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":0,
            "y":0,
            "width":135,
            "height":53
         },Global.Img_Cdm);
         this._grid = new View_Grid();
         this._grid.set_bmp_bg();
         this._grid.set_bmp_over(true,null);
         this._grid.x = 7;
         this._grid.y = 10;
         addChild(this._grid);
         this._tfNumItemNeed = ComponentUtil.getTextField("",this,{
            "x":82,
            "y":4,
            "color":15856113
         });
         ComponentUtil.getBitmap("Ico_JNSP16",this,{
            "x":62,
            "y":5
         },Global.ShenBingdm);
         this.btn = ComponentUtil.getButton("兑换","BT_DH",this,{
            "x":63,
            "y":23,
            "textColor":15856113,
            "callBack":this.btnClickHd
         },Global.ShenBingdm);
      }
      
      public function update(id:Number, index:int) : void
      {
         var vo:Vo_grid = null;
         if(id == 0)
         {
            visible = false;
            return;
         }
         visible = visible || true;
         if(Boolean(Data_lib.item[id]))
         {
            vo = new Vo_item();
            vo.id = id;
            (vo as Vo_item).Init_lib();
         }
         else
         {
            vo = new Vo_ShenBingSkill();
            vo.id = id;
            (vo as Vo_ShenBingSkill).posType = Vo_ShenBingSkill.PT_IDLE;
            (vo as Vo_ShenBingSkill).init_lib();
         }
         this._cost = Data_lib.sbduihuan[index + 1][Enum_ShenBing.SKILL_SOLD_COST];
         this._tfNumItemNeed.text = "×" + this._cost;
         this._grid.vo = vo;
      }
      
      public function btnClickHd(e:MouseEvent) : void
      {
         var txt:String = LangConfig.reTxt("<font color=\'#eeeeee\'>确定用<font color=\'#ffff33\'>{0}</font>个{1}购买<font color=\'#ffff33\'>{2}</font>?</font>",this._cost,Data_lib.item[ShenBingUtil.SHENBING_CHIP_ID][Enum_lib_item.STR_NAME],this._grid.vo.str_name);
         View_Alert.show(txt,View_Alert.OK_CANCAL,function():void
         {
            ShenBingCGMessage.CG_SHENBING_BUY_SKILL(_grid.vo.id,1);
         });
      }
   }
}

