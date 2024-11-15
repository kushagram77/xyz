package com.yash.onlinehomedecor.domain;

/**
 * @author Kushagra Mishra
 */
public class ProductCategories {
        private Integer id;
        private String name;
        private Integer created_by;  // Changed from String to Integer to match DB
        private Integer shop_id;

        public Integer getId() {
                return id;
        }

        public void setId(Integer id) {
                this.id = id;
        }

        public String getName() {
                return name;
        }

        public void setName(String name) {
                this.name = name;
        }

        public Integer getCreated_by() {  // Changed return type to Integer
                return created_by;
        }

        public void setCreated_by(Integer created_by) {  // Changed parameter type to Integer
                this.created_by = created_by;
        }

        public Integer getShop_id() {
                return shop_id;
        }

        public void setShop_id(Integer shop_id) {
                this.shop_id = shop_id;
        }
}
