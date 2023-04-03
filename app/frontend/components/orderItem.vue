<template>
  <div class="field is-horizontal" v-if="orderItem">
      <div class="field-body">
          <div class="field">
              <div class="control">
              <span class="select">
                  <%= f.collection_select :item_id, @purchase.store.items, :id, :name %>
              </span>
              </div>
          </div>
          <div class="field">
              <div class="control">
              <%= f.number_field :quantity, class:'input' %>
              </div>
          </div>
          <div class="field has-remove-button">
              <span class="icon is-danger" @click="cancel">
                  <i class="fa fa-times"></i>
              </span>
              
          </div>
      </div>    
  </div>
</template>
<script>
export default{
  name:'orderItem',
  data: function(){
    return {
        orderItem: true,
    }
  },
  methods:{
    cancel(){
        console.log('cancelled')
        this.orderItem = false;
    }
  }

};
</script>
<style scoped>
</style>