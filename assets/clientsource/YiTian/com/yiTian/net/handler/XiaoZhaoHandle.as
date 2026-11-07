package com.yiTian.net.handler
{
   import com.yiTian.data.model.Model_XiaoZhao;
   import com.yiTian.view.modules.xiaozhao.Child_XiaoZhao_MainIcon;
   import com.yiTian.view.modules.xiaozhao.View_XiaoZhao;
   
   public class XiaoZhaoHandle
   {
      
      public function XiaoZhaoHandle()
      {
         super();
      }
      
      public static function GC_XIAOZHAO_GET_WARD(id:int) : void
      {
         Model_XiaoZhao.setCardStateData(Model_XiaoZhao.curIndex);
         View_XiaoZhao.getInstance().cardState = id;
      }
      
      public static function CG_XIAOZHAO_OPEN_WIN(p:Array, c:Array, state:int) : void
      {
         Model_XiaoZhao.show_Awards = p;
         Model_XiaoZhao.questArr = c;
         Model_XiaoZhao.STATE_XIPAI = state;
         if(Boolean(View_XiaoZhao.getInstance()) && View_XiaoZhao.getInstance().visible)
         {
            View_XiaoZhao.getInstance().setData();
         }
      }
      
      public static function GC_XIAOZHAO_REFRESH() : void
      {
         View_XiaoZhao.getInstance().mvController();
         View_XiaoZhao.getInstance().updataPropNum();
      }
      
      public static function GC_XIAOZHAO_SHOWICON(flag:int) : void
      {
         if(flag == 1)
         {
            Child_XiaoZhao_MainIcon.getInstance().addIcon();
         }
         else
         {
            Child_XiaoZhao_MainIcon.getInstance().dispose();
         }
      }
   }
}

