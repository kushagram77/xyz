package com.yash.onlinehomedecor.domain;
/**
 *
 * @author Kushagra Mishra
 */

public class Shops {
    private Integer id;
    private Integer user_id;
    private String shop_name;
    private String address_line1;
    private String city;
    private String state;
    private String postal_code;
    private String contact_phone;
    private String business_registration_number;
    private ShopStatus status;
    private String shopDescription;

    public void setShop_description(String shopDescription) {
            this.shopDescription=shopDescription;
    }

    public Object getShop_description() {
        return shopDescription;
    }

    public enum ShopStatus
    {    PENDING,    ACTIVE,    SUSPENDED}
    public Integer getId()
    {        return id;    }

    public Integer getUser_id()
    {        return user_id;    }
    public void setUser_id(Integer user_id)
    {        this.user_id = user_id;    }
    public String getShop_name()
    {        return shop_name;    }
    public void setShop_name(String shop_name)
    {        this.shop_name = shop_name;    }
    public String getAddress_line1()
    {        return address_line1;    }
    public void setAddress_line1(String address_line1)
    {        this.address_line1 = address_line1;    }
    public String getCity()
    {        return city;    }
    public void setCity(String city)
    {        this.city = city;    }
    public String getState()
    {        return state;    }
    public void setState(String state)
    {        this.state = state;    }
    public String getPostal_code()
    {        return postal_code;    }
    public void setPostal_code(String postal_code)
    {        this.postal_code = postal_code;    }
    public String getContact_phone()
    {        return contact_phone;    }
    public void setContact_phone(String contact_phone)
    {        this.contact_phone = contact_phone;    }
    public String getBusiness_registration_number()
    {        return business_registration_number;    }
    public void setBusiness_registration_number(String business_registration_number)
    {        this.business_registration_number = business_registration_number;    }
    public ShopStatus getStatus()
    {        return status;    }
    public void setStatus(ShopStatus status)
    {        this.status = status;    }
    public void setId(Integer id)
    {        this.id = id;    }

}