package com.service;

import com.DAO.TotalsutdentDAO;

public class TotalStudent {

    private TotalsutdentDAO totalsutdentDAO;

    public TotalStudent() {
        this.totalsutdentDAO = new TotalsutdentDAO();
    }

    public int getTotalStudentCount() throws Exception {
        return totalsutdentDAO.getTotalStudentCount();
    }
}