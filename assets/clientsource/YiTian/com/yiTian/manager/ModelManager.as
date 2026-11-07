package com.yiTian.manager
{
   import com.yiTian.data.model.Model_bag;
   import com.yiTian.data.model.Model_depot;
   import com.yiTian.data.model.Model_little_system;
   import com.yiTian.data.model.Model_role;
   import com.yiTian.view.modules.panel.Child_otherRoleEquip;
   
   public class ModelManager
   {
      
      public static var bag:Model_bag = new Model_bag();
      
      public static var rolePanel:Model_role = new Model_role();
      
      public static var otherRolePanel:Child_otherRoleEquip = new Child_otherRoleEquip();
      
      public static var depot:Model_depot = new Model_depot();
      
      public static var little_system:Model_little_system = new Model_little_system();
      
      public function ModelManager()
      {
         super();
      }
   }
}

