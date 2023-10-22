package db

import (
	"context"
	"github.com/dapetoo/simple-bank/util"
	"github.com/stretchr/testify/require"
	"testing"
)

func createRandomEntry(t *testing.T, account Account) Entry {

	arg := CreatEntryParams{
		AccountID: account.ID,
		Amount:    util.RandomMoney(),
	}

	entry, err := testQueries.CreatEntry(context.Background(), arg)
	require.NoError(t, err)
	require.NotEmpty(t, entry)

	require.Equal(t, arg.AccountID, entry.AccountID)
	require.Equal(t, arg.Amount, entry.Amount)

	require.NotZero(t, entry.ID)
	require.NotZero(t, entry.CreatedAt)
	return entry
}
