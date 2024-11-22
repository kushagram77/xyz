package com.yash.onlinehomedecor.domain;

import javax.persistence.*;
import java.util.Arrays;

/**
 *
 * @author Kushagra Mishra
 */
public class Product {
    private Integer id;
    private String name;
    private String description;
    private Integer price;
    private Integer category_id;
    private Integer seller_id;
    private Integer shop_id;
    private boolean available;

//    @Lob
//    @Column(name = "image", columnDefinition = "MEDIUMBLOB")
@Column(name = "image")
@Basic(fetch = FetchType.LAZY)

 // @Transient
@Lob
private byte[] image;


    // Getters and setters

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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Integer getPrice() {
        return price;
    }

    public void setPrice(Integer price) {
        this.price = price;
    }

    public Integer getCategory_id() {
        return category_id;
    }

    public void setCategory_id(Integer category_id) {
        this.category_id = category_id;
    }

    public Integer getSeller_id() {
        return seller_id;
    }

    public void setSeller_id(Integer seller_id) {
        this.seller_id = seller_id;
    }

    public Integer getShop_id() {
        return shop_id;
    }

    public void setShop_id(Integer shop_id) {
        this.shop_id = shop_id;
    }

    public boolean isAvailable() {
        return available;
    }

    public void setAvailable(boolean available) {
        this.available = available;
    }

    public byte[] getImage() {
        return image;
    }

    public void setImage(byte[] image) {
        this.image = image;
    }

    @Override
    public String toString() {
        return "Product{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", price=" + price +
                ", category_id=" + category_id +
                ", seller_id=" + seller_id +
                ", shop_id=" + shop_id +
                ", available=" + available +
                ", image=" + Arrays.toString(image) +
                '}';
    }
}