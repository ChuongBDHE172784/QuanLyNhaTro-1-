package nhatro.model;

import java.io.Serializable;

public class Room implements Serializable {
    private int id;
    private String code;
    private String area;
    private int priceMonth;
    private String status; // AVAILABLE | RENTED | MAINTENANCE
    private String description;

    public Room() {
    }

    public Room(int id, String code, String area, int priceMonth, String status, String description) {
        this.id = id;
        this.code = code;
        this.area = area;
        this.priceMonth = priceMonth;
        this.status = status;
        this.description = description;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public int getPriceMonth() {
        return priceMonth;
    }

    public void setPriceMonth(int priceMonth) {
        this.priceMonth = priceMonth;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}

