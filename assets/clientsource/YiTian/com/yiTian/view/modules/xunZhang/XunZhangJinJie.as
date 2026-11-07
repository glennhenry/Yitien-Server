package com.yiTian.view.modules.xunZhang
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.model.Model_role;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.XunZhangCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Sprite;
   
   public class XunZhangJinJie extends Sprite
   {
      
      private static var isFirstLoad:Boolean = true;
      
      private var grid:View_Grid;
      
      private var childXJVec:Vector.<Child_xunZhangJinJie>;
      
      private var tfCost:MyTextField;
      
      private var btnJinJie:Button;
      
      public var preId:int;
      
      public var willId:int;
      
      private var tfManJi:MyTextField;
      
      public function XunZhangJinJie()
      {
         var i:int;
         var childXJinJie:Child_xunZhangJinJie = null;
         this.childXJVec = new Vector.<Child_xunZhangJinJie>();
         super();
         ComponentUtil.getScaleBitmap("Back_Blue",[3,4,1,406],this,{
            "x":239,
            "y":70,
            "width":205,
            "height":417
         },Global.XunZhangdm);
         i = 0;
         while(i < 2)
         {
            childXJinJie = new Child_xunZhangJinJie();
            addChild(childXJinJie);
            childXJinJie.initTye(i);
            this.childXJVec.push(childXJinJie);
            ComponentUtil.setPropertie(childXJinJie,{
               "x":30 + i * 417,
               "y":69
            });
            i++;
         }
         ComponentUtil.getScaleBitmap("Back_HuaWen",[22,19,1,1],this,{
            "x":27,
            "y":67,
            "width":629,
            "height":422
         },Global.XunZhangdm);
         ComponentUtil.getBitmap("JianTou",this,{
            "x":269,
            "y":213
         },Global.XunZhangdm);
         ComponentUtil.getBitmap("Text_XZJJ",this,{
            "x":279,
            "y":166
         },Global.XunZhangdm);
         ComponentUtil.getTextField("进阶所需材料",this,{
            "x":300,
            "y":268,
            "color":14013822,
            "size":14,
            "leading":0
         });
         ComponentUtil.getTextField("进阶费用",this,{
            "x":267,
            "y":360,
            "color":14013822,
            "size":12,
            "leading":0
         });
         ComponentUtil.getScaleBitmap("Text_Back",[6,6,4,4],this,{
            "x":327,
            "y":358,
            "width":90,
            "height":22
         },Global.Img_Cdm);
         this.tfCost = ComponentUtil.getTextField("999999",this,{
            "x":335,
            "y":359,
            "color":15856113,
            "size":12,
            "leading":0
         });
         this.btnJinJie = ComponentUtil.getButton("","Button_JinJie",this,{
            "x":287,
            "y":419,
            "textColor":16771436,
            "callBack":function():void
            {
               if(GameUnitManager.hero.silver + GameUnitManager.hero.bingSilver < int(tfCost.text))
               {
                  UIManager.centerBroadcast.addMsg("银子不够");
                  return;
               }
               XunZhangCGMessage.CG_XUNZHANG_JINJIE(willId,preId);
            }
         },Global.XunZhangdm);
         this.grid = new View_Grid();
         this.grid.set_bmp_bg();
         this.grid.isAutoLoad = false;
         this.grid.set_bmp_over(true,null);
         addChild(this.grid);
         ComponentUtil.setPropertie(this.grid,{
            "x":325,
            "y":297
         });
      }
      
      public function update() : void
      {
         var item:Child_xunZhangJinJie = null;
         var _vo:Vo_equip = null;
         var ss:String = null;
         var _a:Array = null;
         var vo_i:Vo_item = null;
         var _num:int = 0;
         var _ss:String = null;
         for each(item in this.childXJVec)
         {
            item.update();
         }
         _vo = Model_role.xunZhangVo as Vo_equip;
         if(!_vo)
         {
            return;
         }
         var _id:int = _vo.id;
         if(_id < 99145)
         {
            this.preId = _id;
            this.willId = this.preId + 1;
            ss = Data_lib.compose[_id][3];
            _a = ss.split("_");
            vo_i = new Vo_item();
            vo_i.id = _a[0];
            vo_i.count = _a[1];
            vo_i.Init_lib();
            this.grid.vo = vo_i;
            this.tfCost.htmlText = Data_lib.compose[_id][2];
            _num = CommandManager.get_bag_count(vo_i.id);
            if(_num < vo_i.count)
            {
               this.btnJinJie.enabled = false;
               _ss = "#fe0000";
            }
            else
            {
               this.grid.filters = [];
               this.btnJinJie.enabled = true;
               _ss = "#f9ff00";
            }
            this.grid.visible = true;
            if(Boolean(this.tfManJi))
            {
               this.tfManJi.visible = false;
            }
            this.grid.set_tf_info(HtmlUtil.font("\n" + _num + "/" + vo_i.count,_ss),this.grid.numChildren - 1);
            if(isFirstLoad)
            {
               isFirstLoad = false;
               this.grid.isAutoLoad = true;
               this.grid.beginLoad();
            }
         }
         else
         {
            if(!this.tfManJi)
            {
               this.tfManJi = ComponentUtil.getTextField("",this,{
                  "x":this.grid.x - 1,
                  "y":this.grid.y + 13
               });
            }
            this.grid.visible = false;
            this.tfManJi.visible = true;
            this.tfManJi.htmlText = HtmlUtil.font("已满级","#fe0000");
            this.btnJinJie.enabled = false;
            this.tfCost.htmlText = "0";
         }
      }
   }
}

