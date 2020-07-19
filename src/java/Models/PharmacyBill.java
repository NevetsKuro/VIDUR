/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Models;

import java.sql.Date;

/**
 *
 * @author Nevets
 */
public class PharmacyBill {

    Date bill_date;
    String patient_name, patient_Id, pharm_date, itemName, qty, bill_no, who_pays;
    int cut, price, sgst, cgst, total, finalTots, trp_credit;

    public String getWho_pays() {
        return who_pays;
    }

    public void setWho_pays(String who_pays) {
        this.who_pays = who_pays;
    }

    public int getTrp_credit() {
        return trp_credit;
    }

    public void setTrp_credit(int trp_credit) {
        this.trp_credit = trp_credit;
    }

    public String getPatient_name() {
        return patient_name;
    }

    public void setPatient_name(String patient_name) {
        this.patient_name = patient_name;
    }

    public String getPatient_Id() {
        return patient_Id;
    }

    public void setPatient_Id(String patient_Id) {
        this.patient_Id = patient_Id;
    }

    public String getPharm_date() {
        return pharm_date;
    }

    public void setPharm_date(String pharm_date) {
        this.pharm_date = pharm_date;
    }

    public int getCut() {
        return cut;
    }

    public void setCut(int cut) {
        this.cut = cut;
    }

    public String getBill_no() {
        return bill_no;
    }

    public void setBill_no(String bill_no) {
        this.bill_no = bill_no;
    }

    public PharmacyBill() {
    }

    public Date getBill_date() {
        return bill_date;
    }

    public void setBill_date(Date bill_date) {
        this.bill_date = bill_date;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public String getQty() {
        return qty;
    }

    public void setQty(String qty) {
        this.qty = qty;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getSgst() {
        return sgst;
    }

    public void setSgst(int sgst) {
        this.sgst = sgst;
    }

    public int getCgst() {
        return cgst;
    }

    public void setCgst(int cgst) {
        this.cgst = cgst;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public int getFinalTots() {
        return finalTots;
    }

    public void setFinalTots(int finalTots) {
        this.finalTots = finalTots;
    }

}
