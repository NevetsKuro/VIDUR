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
public class DurDialSess {

    String time, BP, pulse, uf_rate, uf_volume, bf_rate, ap, vp, tmp, ktv, cbv;

    public DurDialSess() {
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getBP() {
        return BP;
    }

    public void setBP(String BP) {
        this.BP = BP;
    }

    public String getPulse() {
        return pulse;
    }

    public void setPulse(String pulse) {
        this.pulse = pulse;
    }

    public String getUf_rate() {
        return uf_rate;
    }

    public void setUf_rate(String uf_rate) {
        this.uf_rate = uf_rate;
    }

    public String getUf_volume() {
        return uf_volume;
    }

    public void setUf_volume(String uf_volume) {
        this.uf_volume = uf_volume;
    }

    public String getBf_rate() {
        return bf_rate;
    }

    public void setBf_rate(String bf_rate) {
        this.bf_rate = bf_rate;
    }

    public String getAp() {
        return ap;
    }

    public void setAp(String ap) {
        this.ap = ap;
    }

    public String getVp() {
        return vp;
    }

    public void setVp(String vp) {
        this.vp = vp;
    }

    public String getTmp() {
        return tmp;
    }

    public void setTmp(String tmp) {
        this.tmp = tmp;
    }

    public String getKtv() {
        return ktv;
    }

    public void setKtv(String ktv) {
        this.ktv = ktv;
    }

    public String getCbv() {
        return cbv;
    }

    public void setCbv(String cbv) {
        this.cbv = cbv;
    }

}
